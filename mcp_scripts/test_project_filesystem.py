"""Temporary-directory safety checks for the project filesystem MCP tools."""

import tempfile
from pathlib import Path

import mcp_project_filesystem as server


def main() -> None:
    tools = [tool.name for tool in server.mcp._tool_manager.list_tools()]
    assert set(tools) == {"list_files", "read_file", "create_file", "edit_file"}
    assert not any("delete" in name.lower() or "remove" in name.lower() for name in tools)

    with tempfile.TemporaryDirectory() as temporary_directory:
        server.PROJECT_ROOT = Path(temporary_directory).resolve()
        server.create_file("sample.txt", "alpha beta")
        assert server.read_file("sample.txt")["content"] == "alpha beta"
        assert server.edit_file("sample.txt", "alpha", "gamma")["replacements"] == 1
        assert server.read_file("sample.txt")["content"] == "gamma beta"

        try:
            server.create_file("sample.txt", "overwrite")
        except FileExistsError:
            pass
        else:
            raise AssertionError("create_file overwrote an existing file")

        try:
            server.read_file("../outside.txt")
        except ValueError:
            pass
        else:
            raise AssertionError("Path traversal was accepted")

    print("Filesystem MCP safety tests passed; tools:", tools)


if __name__ == "__main__":
    main()