# Oracle MCP server

**MCP server name:** `oracle_db_mcp`  
**Transport:** stdio  
**Script:** `mcp_scripts/mcp_oracle_server.py`

To verify the complete MCP stdio handshake and Oracle read access, configure the
environment variables below and run `python mcp_scripts/test_oracle_mcp.py`.
This smoke test lists the tools and reads at most five `PAY_EXCEPTIONS` rows.

The server provides `list_tables`, `describe_table`, `query_table`,
`insert_record`, `update_records`, and `delete_records`. Reads are available by
default. DML writes are disabled until explicitly enabled. Update and delete
require an equality filter; values are bound parameters and identifiers are
validated. Enabled DML commits immediately.

## Install and run

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r mcp_scripts/requirements-oracle-mcp.txt
export ORACLE_USER=FUSION
export ORACLE_PASSWORD=FUSION
# No SYSDBA role is used for the FUSION schema account.
export ORACLE_HOST=localhost ORACLE_PORT=1521 ORACLE_SERVICE=FREEPDB1
python mcp_scripts/mcp_oracle_server.py
```

Set these variables in your MCP host's server process environment. Never store
the password in source control or an unprotected config file. SYSDBA is highly
privileged; prefer a least-privileged account for normal CRUD. The server uses
stdio, so the MCP client launches it and its process normally waits quietly.
Connection timeout defaults to 5 seconds; Oracle call timeout defaults to 15
seconds. Override with `ORACLE_CONNECT_TIMEOUT` and `ORACLE_CALL_TIMEOUT_MS`.

Set `ORACLE_WRITE_ENABLED=true` in the MCP server process environment to enable
insert/update/delete tools. Keep it false for read-only access.

## CRUD tool examples

Examples use `FUSION.PAY_EXCEPTIONS`; inspect the table first because actual
columns and required fields vary by Oracle installation.

1. **Inspect columns** — call `describe_table`:

```json
{"schema":"FUSION","table":"PAY_EXCEPTIONS"}
```

2. **Create/read** — call `query_table`:

```json
{"schema":"FUSION","table":"PAY_EXCEPTIONS","limit":20}
```

3. **Insert** — call `insert_record` (illustrative only; supply all required
   columns and valid values for your schema):

```json
{"schema":"FUSION","table":"YOUR_TEST_TABLE","values":{"ID":101,"NAME":"Example"}}
```

4. **Update** — call `update_records` with a restrictive key filter:

```json
{"schema":"FUSION","table":"YOUR_TEST_TABLE","values":{"NAME":"Updated"},"where_column":"ID","where_value":101}
```

5. **Delete** — call `delete_records` with a restrictive key filter:

```json
{"schema":"FUSION","table":"YOUR_TEST_TABLE","where_column":"ID","where_value":101}
```

`query_table` has a default limit of 100 and maximum of 1,000 rows. Do not test
write examples against production data. Oracle grants must permit each action.