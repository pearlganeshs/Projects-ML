"""Filesystem MCP restricted to safe, non-deleting project file operations."""

import os
from pathlib import Path

from mcp.server.fastmcp import FastMCP

PROJECT_ROOT = Path(
    os.environ.get(
        "PROJECT_FILESYSTEM_ROOT",
        str(Path(__file__).resolve().parent.parent),
    )
).resolve(strict=True)

mcp = FastMCP("project_filesystem_mcp")


def _resolve_project_path(path: str) -> Path:
    """Resolve a relative project path and reject traversal/symlink escapes."""
    candidate = Path(path)
    if candidate.is_absolute():
        raise ValueError("Use a project-relative path, not an absolute path.")
    resolved = (PROJECT_ROOT / candidate).resolve(strict=False)
    try:
        resolved.relative_to(PROJECT_ROOT)
    except ValueError as exc:
        raise ValueError("Path must remain inside the configured project root.") from exc
    return resolved


@mcp.tool()
def list_files(path: str = ".", recursive: bool = False) -> list[dict[str, str]]:
    """List files and directories under the project root (no file contents)."""
    directory = _resolve_project_path(path)
    if not directory.exists() or not directory.is_dir():
        raise ValueError("Path must be an existing project directory.")
    iterator = directory.rglob("*") if recursive else directory.iterdir()
    entries: list[dict[str, str]] = []
    for entry in sorted(iterator):
        try:
            entry.resolve(strict=False).relative_to(PROJECT_ROOT)
        except ValueError:
            continue  # Do not follow/report symlinks that escape the project.
        entries.append({
            "path": entry.relative_to(PROJECT_ROOT).as_posix(),
            "type": "directory" if entry.is_dir() else "file",
        })
    return entries


@mcp.tool()
def read_file(path: str, max_chars: int = 100_000) -> dict[str, str | bool]:
    """Read a UTF-8 text file within the project root, with a size limit."""
    if not 1 <= max_chars <= 1_000_000:
        raise ValueError("max_chars must be between 1 and 1,000,000")
    target = _resolve_project_path(path)
    if not target.is_file():
        raise ValueError("Path must be an existing project file.")
    with target.open("r", encoding="utf-8") as file:
        content = file.read(max_chars + 1)
    truncated = len(content) > max_chars
    return {"path": target.relative_to(PROJECT_ROOT).as_posix(),
            "content": content[:max_chars], "truncated": truncated}


@mcp.tool()
def create_file(path: str, content: str) -> dict[str, str]:
    """Create a new UTF-8 file; refuses to overwrite any existing path."""
    target = _resolve_project_path(path)
    if target.exists():
        raise FileExistsError(f"File already exists: {path}")
    if not target.parent.is_dir():
        raise ValueError("Parent directory must already exist inside the project.")
    # Exclusive create prevents overwriting an existing file, including races.
    with target.open("x", encoding="utf-8", newline="") as file:
        file.write(content)
    return {"path": target.relative_to(PROJECT_ROOT).as_posix(), "created": "true"}


@mcp.tool()
def edit_file(path: str, old_text: str, new_text: str, replace_all: bool = False) -> dict[str, int | str]:
    """Replace matching text in a UTF-8 file; requires an exact existing match."""
    if not old_text:
        raise ValueError("old_text must not be empty")
    target = _resolve_project_path(path)
    if not target.is_file():
        raise ValueError("Path must be an existing project file.")
    content = target.read_text(encoding="utf-8")
    count = content.count(old_text)
    if count == 0:
        raise ValueError("old_text was not found; file was not changed.")
    if count > 1 and not replace_all:
        raise ValueError(
            f"old_text appears {count} times; use a unique snippet or set replace_all=true."
        )
    updated = content.replace(old_text, new_text) if replace_all else content.replace(old_text, new_text, 1)
    target.write_text(updated, encoding="utf-8")
    return {"path": target.relative_to(PROJECT_ROOT).as_posix(),
            "replacements": count if replace_all else 1}


if __name__ == "__main__":
    mcp.run(transport="stdio")