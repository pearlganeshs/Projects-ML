"""Smoke-test MCP handshake and Graphify knowledge graph queries without side effects."""

import asyncio
import json
import os
import sys
import tempfile
from pathlib import Path

from mcp import ClientSession, StdioServerParameters
from mcp.client.stdio import stdio_client


def _seed_sample_graph(root: Path) -> None:
    """Create a minimal valid graphify-out fixture for standalone verification."""
    out_dir = root / "graphify-out"
    out_dir.mkdir(parents=True, exist_ok=True)
    sample_graph = {
        "schema_version": "1.0",
        "graphify_version": "test-fixture",
        "nodes": [
            {"id": "api.py::fetch", "label": "fetch", "type": "function", "file": "api.py"},
            {"id": "db.py::connect", "label": "connect", "type": "function", "file": "db.py"},
        ],
        "links": [
            {
                "source": "api.py::fetch",
                "target": "db.py::connect",
                "relation": "calls",
                "confidence": "EXTRACTED",
            }
        ],
    }
    (out_dir / "graph.json").write_text(json.dumps(sample_graph), encoding="utf-8")
    (out_dir / "GRAPH_REPORT.md").write_text("# Sample Graph Report\n", encoding="utf-8")


async def main() -> None:
    server_script = Path(__file__).with_name("mcp_graphify_server.py")

    with tempfile.TemporaryDirectory() as tmp_dir:
        tmp_root = Path(tmp_dir)
        _seed_sample_graph(tmp_root)

        env = os.environ.copy()
        env.setdefault("GRAPHIFY_PROJECT_ROOT", str(tmp_root))

        params = StdioServerParameters(
            command=sys.executable,
            args=["-u", str(server_script)],
            env=env,
        )
        async with asyncio.timeout(25):
            async with stdio_client(params) as (read_stream, write_stream):
                async with ClientSession(read_stream, write_stream) as session:
                    await session.initialize()
                    tools = await session.list_tools()
                    print("MCP handshake: OK")
                    print("MCP tools:", ", ".join(tool.name for tool in tools.tools))

                    stats = await session.call_tool("get_graph_stats", {})
                    print("Stats error:", stats.isError)
                    for item in stats.content:
                        if getattr(item, "text", None):
                            print("Stats output:", item.text)

                    search = await session.call_tool("search_nodes", {"query": "fetch"})
                    for item in search.content:
                        if getattr(item, "text", None):
                            print("Search output:", item.text)


if __name__ == "__main__":
    try:
        asyncio.run(main())
    except TimeoutError:
        print("Graphify MCP smoke test timed out after 25 seconds.", file=sys.stderr)
        raise SystemExit(2)
