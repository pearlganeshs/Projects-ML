"""Smoke-test MCP handshake and Figma API authentication without making edits.

Run with FIGMA_ACCESS_TOKEN set in the environment. Optionally set
FIGMA_TEST_FILE_KEY to also verify reading file metadata.
"""

import asyncio
import os
import sys
from pathlib import Path

from mcp import ClientSession, StdioServerParameters
from mcp.client.stdio import stdio_client


async def main() -> None:
    server_script = Path(__file__).with_name("mcp_figma_server.py")
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

                me_result = await session.call_tool("get_current_user", {})
                print("Figma auth error:", me_result.isError)
                for item in me_result.content:
                    if getattr(item, "text", None):
                        print("User info:", item.text)

                test_key = os.environ.get("FIGMA_TEST_FILE_KEY", "").strip()
                if test_key:
                    file_result = await session.call_tool(
                        "get_file_summary", {"file_key": test_key, "depth": 1}
                    )
                    for item in file_result.content:
                        if getattr(item, "text", None):
                            print("File summary:", item.text)


if __name__ == "__main__":
    try:
        asyncio.run(main())
    except TimeoutError:
        print("Figma MCP smoke test timed out after 25 seconds.", file=sys.stderr)
        raise SystemExit(2)
