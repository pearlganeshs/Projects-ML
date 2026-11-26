"""Oracle MCP server with safe, parameterized CRUD tools."""

import os
import re
from typing import Any

import oracledb
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("oracle_db_mcp")
_IDENTIFIER = re.compile(r"^[A-Za-z][A-Za-z0-9_$#]*$")
_MAX_ROWS = 1000
_CALL_TIMEOUT_MS = int(os.environ.get("ORACLE_CALL_TIMEOUT_MS", "15000"))
_CONNECT_TIMEOUT = float(os.environ.get("ORACLE_CONNECT_TIMEOUT", "5"))
_WRITES_ENABLED = os.environ.get("ORACLE_WRITE_ENABLED", "false").lower() in {
    "true", "1", "yes"
}


def _identifier(value: str, label: str) -> str:
    if not _IDENTIFIER.fullmatch(value):
        raise ValueError(f"Invalid {label}: {value!r}")
    return value.upper()


def _connect() -> oracledb.Connection:
    password = os.environ.get("ORACLE_PASSWORD")
    if not password:
        raise ValueError("Set ORACLE_PASSWORD in the MCP process environment.")
    args: dict[str, Any] = {
        "user": os.environ.get("ORACLE_USER", "system"),
        "password": password,
        "host": os.environ.get("ORACLE_HOST", "localhost"),
        "port": int(os.environ.get("ORACLE_PORT", "1521")),
        "service_name": os.environ.get("ORACLE_SERVICE", "FREEPDB1"),
        "tcp_connect_timeout": _CONNECT_TIMEOUT,
        "retry_count": 0,
    }
    role = os.environ.get("ORACLE_ROLE", "").upper()
    if role:
        if role != "SYSDBA":
            raise ValueError("ORACLE_ROLE must be SYSDBA or unset.")
        args["mode"] = oracledb.AUTH_MODE_SYSDBA
    return oracledb.connect(**args)


def _run_dml(sql: str, binds: dict[str, Any]) -> dict[str, Any]:
    if not _WRITES_ENABLED:
        raise PermissionError(
            "Writes are disabled. Set ORACLE_WRITE_ENABLED=true to enable DML."
        )
    with _connect() as connection:
        connection.call_timeout = _CALL_TIMEOUT_MS
        with connection.cursor() as cursor:
            cursor.execute(sql, binds)
            affected = cursor.rowcount
        connection.commit()
    return {"rows_affected": affected, "committed": True}


@mcp.tool()
def list_tables(schema: str | None = None) -> list[dict[str, str]]:
    """List accessible tables, optionally for one schema."""
    sql = "SELECT owner, table_name FROM all_tables"
    binds: dict[str, Any] = {}
    if schema:
        sql += " WHERE owner = :owner"
        binds["owner"] = _identifier(schema, "schema")
    sql += " ORDER BY owner, table_name FETCH FIRST 500 ROWS ONLY"
    with _connect() as connection:
        connection.call_timeout = _CALL_TIMEOUT_MS
        with connection.cursor() as cursor:
            cursor.execute(sql, binds)
            return [{"owner": r[0], "table_name": r[1]} for r in cursor]


@mcp.tool()
def describe_table(table: str, schema: str = "FUSION") -> list[dict[str, str]]:
    """Return column names and data types for an accessible table or view."""
    owner, name = _identifier(schema, "schema"), _identifier(table, "table")
    with _connect() as connection:
        connection.call_timeout = _CALL_TIMEOUT_MS
        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT column_name, data_type FROM all_tab_columns "
                "WHERE owner = :owner AND table_name = :name ORDER BY column_id",
                owner=owner, name=name,
            )
            return [{"column_name": r[0], "data_type": r[1]} for r in cursor]


@mcp.tool()
def query_table(
    table: str,
    schema: str = "FUSION",
    columns: list[str] | None = None,
    where_column: str | None = None,
    where_value: Any = None,
    limit: int = 100,
) -> dict[str, Any]:
    """Select rows with an optional equality filter; maximum 1,000 rows."""
    if not 1 <= limit <= _MAX_ROWS:
        raise ValueError(f"limit must be between 1 and {_MAX_ROWS}")
    owner, name = _identifier(schema, "schema"), _identifier(table, "table")
    selected = [_identifier(c, "column") for c in columns] if columns else ["*"]
    binds: dict[str, Any] = {"row_limit": limit}
    predicate = ""
    if where_column is not None:
        if where_value is None:
            raise ValueError("where_value is required with where_column")
        predicate = f" WHERE {_identifier(where_column, 'filter column')} = :filter_value"
        binds["filter_value"] = where_value
    sql = (f"SELECT {', '.join(selected)} FROM {owner}.{name}{predicate} "
           "FETCH FIRST :row_limit ROWS ONLY")
    with _connect() as connection:
        connection.call_timeout = _CALL_TIMEOUT_MS
        with connection.cursor() as cursor:
            cursor.execute(sql, binds)
            names = [d[0] for d in cursor.description]
            rows = [dict(zip(names, row)) for row in cursor]
    return {"columns": names, "rows": rows, "returned_rows": len(rows)}


@mcp.tool()
def insert_record(table: str, values: dict[str, Any], schema: str = "FUSION") -> dict[str, Any]:
    """Insert one record; commits when ORACLE_WRITE_ENABLED=true."""
    if not values:
        raise ValueError("values must not be empty")
    owner, name = _identifier(schema, "schema"), _identifier(table, "table")
    columns = [_identifier(c, "column") for c in values]
    binds = {f"v{i}": v for i, v in enumerate(values.values())}
    sql = (f"INSERT INTO {owner}.{name} ({', '.join(columns)}) VALUES "
           f"({', '.join(':' + key for key in binds)})")
    return _run_dml(sql, binds)


@mcp.tool()
def update_records(
    table: str, values: dict[str, Any], where_column: str,
    where_value: Any, schema: str = "FUSION",
) -> dict[str, Any]:
    """Update rows matching a required equality filter; commits when enabled."""
    if not values:
        raise ValueError("values must not be empty")
    owner, name = _identifier(schema, "schema"), _identifier(table, "table")
    columns = [_identifier(c, "column") for c in values]
    binds = {f"v{i}": v for i, v in enumerate(values.values())}
    binds["filter_value"] = where_value
    assignments = ", ".join(f"{c} = :v{i}" for i, c in enumerate(columns))
    filter_col = _identifier(where_column, "filter column")
    return _run_dml(
        f"UPDATE {owner}.{name} SET {assignments} WHERE {filter_col} = :filter_value",
        binds,
    )


@mcp.tool()
def delete_records(
    table: str, where_column: str, where_value: Any,
    schema: str = "FUSION",
) -> dict[str, Any]:
    """Delete rows matching a required equality filter; commits when enabled."""
    owner, name = _identifier(schema, "schema"), _identifier(table, "table")
    filter_col = _identifier(where_column, "filter column")
    return _run_dml(
        f"DELETE FROM {owner}.{name} WHERE {filter_col} = :filter_value",
        {"filter_value": where_value},
    )


if __name__ == "__main__":
    mcp.run(transport="stdio")