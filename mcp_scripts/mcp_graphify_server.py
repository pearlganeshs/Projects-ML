"""Graphify MCP server for safe, read-only local knowledge graph querying."""

import json
import os
from collections import deque
from pathlib import Path
from typing import Any

from mcp.server.fastmcp import FastMCP

mcp = FastMCP("graphify_kg_mcp")

_PROJECT_ROOT = Path(
    os.environ.get(
        "GRAPHIFY_PROJECT_ROOT",
        str(Path(__file__).resolve().parent.parent),
    )
).resolve(strict=True)

_GRAPH_OUT_REL = os.environ.get("GRAPHIFY_OUT_DIR", "graphify-out").strip() or "graphify-out"
_MAX_SEARCH_RESULTS = 100
_MAX_EDGES = 100
_MAX_REPORT_CHARS = 100_000


def _resolve_graph_dir() -> Path:
    """Resolve the graphify-out directory and prevent traversal outside PROJECT_ROOT."""
    candidate = Path(_GRAPH_OUT_REL)
    if candidate.is_absolute():
        raise ValueError("GRAPHIFY_OUT_DIR must be a relative path inside GRAPHIFY_PROJECT_ROOT.")
    resolved = (_PROJECT_ROOT / candidate).resolve(strict=False)
    try:
        resolved.relative_to(_PROJECT_ROOT)
    except ValueError as exc:
        raise ValueError("GRAPHIFY_OUT_DIR must remain inside GRAPHIFY_PROJECT_ROOT.") from exc
    return resolved


def _load_graph() -> tuple[list[dict[str, Any]], list[dict[str, Any]], dict[str, Any]]:
    """Load nodes, edges, and metadata from graphify-out/graph.json."""
    graph_file = _resolve_graph_dir() / "graph.json"
    if not graph_file.is_file():
        raise FileNotFoundError(
            f"Graph file not found at {graph_file}. Run 'graphify .' in your project first."
        )
    raw = json.loads(graph_file.read_text(encoding="utf-8"))
    nodes = raw.get("nodes", [])
    links = raw.get("links") or raw.get("edges") or []
    meta = {
        "schema_version": raw.get("schema_version"),
        "graphify_version": raw.get("graphify_version"),
        "graph_path": graph_file.relative_to(_PROJECT_ROOT).as_posix(),
    }
    return nodes, links, meta


@mcp.tool()
def get_graph_stats() -> dict[str, Any]:
    """Return node counts, edge counts, node types, and Graphify schema metadata."""
    nodes, links, meta = _load_graph()
    type_counts: dict[str, int] = {}
    for node in nodes:
        ntype = str(node.get("type") or node.get("kind") or "unknown")
        type_counts[ntype] = type_counts.get(ntype, 0) + 1

    edge_types: dict[str, int] = {}
    for edge in links:
        etype = str(edge.get("relation") or edge.get("type") or "related_to")
        edge_types[etype] = edge_types.get(etype, 0) + 1

    return {
        **meta,
        "total_nodes": len(nodes),
        "total_edges": len(links),
        "node_types": type_counts,
        "edge_types": edge_types,
    }


@mcp.tool()
def read_graph_report(max_chars: int = 20_000) -> dict[str, Any]:
    """Read the generated GRAPH_REPORT.md summary (key concepts, communities, insights)."""
    if not 1 <= max_chars <= _MAX_REPORT_CHARS:
        raise ValueError(f"max_chars must be between 1 and {_MAX_REPORT_CHARS}")
    report_file = _resolve_graph_dir() / "GRAPH_REPORT.md"
    if not report_file.is_file():
        raise FileNotFoundError(f"Report not found at {report_file}.")
    text = report_file.read_text(encoding="utf-8")
    return {
        "path": report_file.relative_to(_PROJECT_ROOT).as_posix(),
        "content": text[:max_chars],
        "truncated": len(text) > max_chars,
    }


@mcp.tool()
def search_nodes(
    query: str,
    node_type: str | None = None,
    limit: int = 20,
) -> dict[str, Any]:
    """Search graph nodes by case-insensitive substring across id, label, and file path."""
    if not query.strip():
        raise ValueError("query must not be empty.")
    if not 1 <= limit <= _MAX_SEARCH_RESULTS:
        raise ValueError(f"limit must be between 1 and {_MAX_SEARCH_RESULTS}")

    nodes, _, _ = _load_graph()
    needle = query.strip().lower()
    type_filter = node_type.strip().lower() if node_type else None

    matches: list[dict[str, Any]] = []
    for node in nodes:
        ntype = str(node.get("type") or node.get("kind") or "unknown")
        if type_filter and ntype.lower() != type_filter:
            continue
        haystack = " ".join(
            str(node.get(k, "")) for k in ("id", "label", "name", "file", "summary")
        ).lower()
        if needle in haystack:
            matches.append(
                {
                    "id": node.get("id"),
                    "label": node.get("label") or node.get("name"),
                    "type": ntype,
                    "file": node.get("file"),
                    "community": node.get("community"),
                }
            )
            if len(matches) >= limit:
                break

    return {"query": query, "returned_nodes": len(matches), "nodes": matches}


@mcp.tool()
def get_node_neighbors(
    node_id: str,
    direction: str = "both",
    max_edges: int = 30,
) -> dict[str, Any]:
    """Inspect incoming, outgoing, or bidirectional edges connected to a specific node ID."""
    if direction not in {"in", "out", "both"}:
        raise ValueError("direction must be one of: 'in', 'out', 'both'")
    if not 1 <= max_edges <= _MAX_EDGES:
        raise ValueError(f"max_edges must be between 1 and {_MAX_EDGES}")

    nodes, links, _ = _load_graph()
    node_map = {str(n.get("id")): n for n in nodes}
    if node_id not in node_map:
        raise ValueError(f"Node ID not found in graph: {node_id!r}")

    connected: list[dict[str, Any]] = []
    for edge in links:
        src = str(edge.get("source"))
        dst = str(edge.get("target"))
        if direction in {"out", "both"} and src == node_id:
            connected.append(
                {
                    "direction": "outgoing",
                    "relation": edge.get("relation") or edge.get("type"),
                    "confidence": edge.get("confidence"),
                    "target": dst,
                }
            )
        elif direction in {"in", "both"} and dst == node_id:
            connected.append(
                {
                    "direction": "incoming",
                    "relation": edge.get("relation") or edge.get("type"),
                    "confidence": edge.get("confidence"),
                    "source": src,
                }
            )
        if len(connected) >= max_edges:
            break

    return {
        "node": node_map[node_id],
        "returned_edges": len(connected),
        "edges": connected,
    }


@mcp.tool()
def find_shortest_path(source_id: str, target_id: str) -> dict[str, Any]:
    """Find the shortest dependency/relationship chain between two node IDs."""
    nodes, links, _ = _load_graph()
    node_ids = {str(n.get("id")) for n in nodes}
    for nid in (source_id, target_id):
        if nid not in node_ids:
            raise ValueError(f"Node ID not found in graph: {nid!r}")

    adj: dict[str, list[tuple[str, str]]] = {nid: [] for nid in node_ids}
    for edge in links:
        src = str(edge.get("source"))
        dst = str(edge.get("target"))
        rel = str(edge.get("relation") or edge.get("type") or "related_to")
        if src in adj and dst in adj:
            adj[src].append((dst, rel))
            adj[dst].append((src, f"<-{rel}"))

    queue: deque[tuple[str, list[dict[str, str]]]] = deque([(source_id, [])])
    visited = {source_id}
    while queue:
        current, path = queue.popleft()
        if current == target_id:
            return {"found": True, "hops": len(path), "path": path}
        for neighbor, rel in adj.get(current, []):
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(
                    (neighbor, [*path, {"from": current, "relation": rel, "to": neighbor}])
                )

    return {"found": False, "hops": -1, "path": []}


if __name__ == "__main__":
    mcp.run(transport="stdio")
