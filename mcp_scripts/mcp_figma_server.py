"""Figma MCP server with safe, read-only Figma REST API inspection tools."""

import os
import re
from typing import Any

import httpx
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("figma_api_mcp")

_BASE_URL = "https://figma.com"
_FILE_KEY_RE = re.compile(r"^[A-Za-z0-9]{10,64}$")
_NODE_ID_RE = re.compile(r"^[0-9]+:[0-9]+$")
_TIMEOUT_SECONDS = float(os.environ.get("FIGMA_TIMEOUT_SECONDS", "20"))
_MAX_DEPTH = 5


def _headers() -> dict[str, str]:
    token = os.environ.get("FIGMA_ACCESS_TOKEN", "").strip()
    if not token:
        raise ValueError("Set FIGMA_ACCESS_TOKEN in the MCP process environment.")
    return {"X-Figma-Token": token}


def _validate_file_key(file_key: str) -> str:
    clean = file_key.strip()
    if not _FILE_KEY_RE.fullmatch(clean):
        raise ValueError(f"Invalid Figma file_key: {file_key!r}")
    return clean


def _validate_node_ids(node_ids: list[str]) -> list[str]:
    if not node_ids:
        raise ValueError("node_ids must not be empty.")
    cleaned: list[str] = []
    for raw in node_ids:
        nid = raw.strip().replace("-", ":")
        if not _NODE_ID_RE.fullmatch(nid):
            raise ValueError(f"Invalid Figma node_id: {raw!r} (expected format like '1:2')")
        cleaned.append(nid)
    return cleaned


async def _figma_get(path: str, params: dict[str, Any] | None = None) -> dict[str, Any]:
    async with httpx.AsyncClient(base_url=_BASE_URL, timeout=_TIMEOUT_SECONDS) as client:
        response = await client.get(path, headers=_headers(), params=params)
        if response.status_code == 403:
            raise PermissionError("Figma API rejected FIGMA_ACCESS_TOKEN (HTTP 403).")
        if response.status_code == 404:
            raise ValueError("Requested Figma file or node was not found (HTTP 404).")
        response.raise_for_status()
        return response.json()


@mcp.tool()
async def get_current_user() -> dict[str, Any]:
    """Verify Figma token validity and return the authenticated user's profile."""
    data = await _figma_get("/me")
    return {
        "id": data.get("id"),
        "handle": data.get("handle"),
        "email": data.get("email"),
    }


@mcp.tool()
async def get_file_summary(file_key: str, depth: int = 2) -> dict[str, Any]:
    """Fetch top-level metadata, pages, and frames for a Figma file (depth 1-5)."""
    if not 1 <= depth <= _MAX_DEPTH:
        raise ValueError(f"depth must be between 1 and {_MAX_DEPTH}")
    key = _validate_file_key(file_key)
    data = await _figma_get(f"/files/{key}", params={"depth": depth})
    document = data.get("document", {})
    pages = [
        {
            "id": page.get("id"),
            "name": page.get("name"),
            "type": page.get("type"),
            "children_count": len(page.get("children", [])),
        }
        for page in document.get("children", [])
    ]
    return {
        "name": data.get("name"),
        "lastModified": data.get("lastModified"),
        "version": data.get("version"),
        "pages": pages,
    }


@mcp.tool()
async def get_file_nodes(file_key: str, node_ids: list[str], depth: int = 2) -> dict[str, Any]:
    """Inspect specific Figma frames, components, or layers by node ID."""
    if not 1 <= depth <= _MAX_DEPTH:
        raise ValueError(f"depth must be between 1 and {_MAX_DEPTH}")
    key = _validate_file_key(file_key)
    ids = _validate_node_ids(node_ids)
    data = await _figma_get(
        f"/files/{key}/nodes",
        params={"ids": ",".join(ids), "depth": depth},
    )
    nodes = data.get("nodes", {})
    return {
        "name": data.get("name"),
        "requested_ids": ids,
        "nodes": {
            nid: {
                "document": payload.get("document") if payload else None,
            }
            for nid, payload in nodes.items()
        },
    }


@mcp.tool()
async def get_file_comments(file_key: str, limit: int = 50) -> dict[str, Any]:
    """List review comments on a Figma file (maximum 200 comments)."""
    if not 1 <= limit <= 200:
        raise ValueError("limit must be between 1 and 200")
    key = _validate_file_key(file_key)
    data = await _figma_get(f"/files/{key}/comments")
    comments = data.get("comments", [])[:limit]
    return {
        "returned_comments": len(comments),
        "comments": [
            {
                "id": c.get("id"),
                "author": c.get("user", {}).get("handle"),
                "message": c.get("message"),
                "created_at": c.get("created_at"),
                "resolved_at": c.get("resolved_at"),
            }
            for c in comments
        ],
    }


@mcp.tool()
async def export_node_images(
    file_key: str,
    node_ids: list[str],
    image_format: str = "png",
    scale: float = 1.0,
) -> dict[str, Any]:
    """Generate temporary download URLs for rendered Figma nodes (png, svg, jpg, pdf)."""
    fmt = image_format.lower().strip()
    if fmt not in {"png", "svg", "jpg", "pdf"}:
        raise ValueError("image_format must be one of: png, svg, jpg, pdf")
    if not 0.5 <= scale <= 4.0:
        raise ValueError("scale must be between 0.5 and 4.0")
    key = _validate_file_key(file_key)
    ids = _validate_node_ids(node_ids)
    data = await _figma_get(
        f"/images/{key}",
        params={"ids": ",".join(ids), "format": fmt, "scale": scale},
    )
    return {
        "format": fmt,
        "scale": scale,
        "images": data.get("images", {}),
    }


if __name__ == "__main__":
    mcp.run(transport="stdio")
