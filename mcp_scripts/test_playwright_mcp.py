"""Smoke-test MCP handshake and a safe Playwright navigation without side effects."""

import asyncio
import os
import sys
from pathlib import Path

from mcp import ClientSession, StdioServerParameters
from mcp.client.stdio import stdio_client


async def main() -> None:
    server_script = Path(__file__).with_name("mcp_playwright_server.py")
    env = os.environ.copy()
    env.setdefault("PLAYWRIGHT_HEADLESS", "true")

    params = StdioServerParameters(
        command=sys.executable,
        args=["-u", str(server_script)],
        env=env,
    )
    async with asyncio.timeout(35):
        async with stdio_client(params) as (read_stream, write_stream):
            async with ClientSession(read_stream, write_stream) as session:
                await session.initialize()
                tools = await session.list_tools()
                print("MCP handshake: OK")
                print("MCP tools:", ", ".join(tool.name for tool in tools.tools))

                nav_result = await session.call_tool(
                    "navigate", {"url": "https://example.com"}
                )
                print("Navigate error:", nav_result.isError)
                for item in nav_result.content:
                    if getattr(item, "text", None):
                        print("Navigate output:", item.text)

                text_result = await session.call_tool(
                    "get_page_text", {"selector": "h1", "max_chars": 200}
                )
                for item in text_result.content:
                    if getattr(item, "text", None):
                        print("Heading output:", item.text)

                await session.call_tool("close_browser", {})


if __name__ == "__main__":
    try:
        asyncio.run(main())
    except TimeoutError:
        print("Playwright MCP smoke test timed out after 35 seconds.", file=sys.stderr)
        raise SystemExit(2)
