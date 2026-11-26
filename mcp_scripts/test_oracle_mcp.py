"""Smoke-test MCP handshake and an Oracle SELECT without making changes.

Run with ORACLE_USER, ORACLE_PASSWORD, ORACLE_HOST, ORACLE_PORT, and
ORACLE_SERVICE set in the environment. Uses the server through MCP stdio.
"""

import asyncio
import os
import sys
from pathlib import Path

from mcp import ClientSession, StdioServerParameters
from mcp.client.stdio import stdio_client


async def main() -> None:
    server_script = Path(__file__).with_name("mcp_oracle_server.py")
    params = StdioServerParameters(
        command=sys.executable,
        args=["-u", str(server_script)],
        env=os.environ.copy(),
    )
    async with asyncio.timeout(25):
        async with stdio_client(params) as (read_stream, write_stream):
            async with ClientSession(read_stream, write_stream) as session:
                await session.initialize()
                tools = await session.list_tools()
                print("MCP handshake: OK")
                print("MCP tools:", ", ".join(tool.name for tool in tools.tools))
                result = await session.call_tool(
                    "query_table",
                    {"schema": "FUSION", "table": "PAY_EXCEPTIONS", "limit": 5},
                )
                print("Oracle query error:", result.isError)
                for item in result.content:
                    if getattr(item, "text", None):
                        print(item.text)


if __name__ == "__main__":
    try:
        asyncio.run(main())
    except TimeoutError:
        print("MCP smoke test timed out after 25 seconds.", file=sys.stderr)
        raise SystemExit(2)