# Project filesystem MCP

**MCP server name:** `project_filesystem_mcp`  
**Transport:** stdio  
**Default project root:** `/Users/muthsubr/d/Learnings/DS_ML/Projects/Projects-ML`

This server only lists, reads, creates, and edits UTF-8 files inside the project
root. It intentionally has **no delete/remove tool**. Paths must be relative;
path traversal and symlink escapes are rejected. `create_file` refuses to
overwrite existing files. `edit_file` requires an exact old-text match and
rejects ambiguous matches unless `replace_all=true` is explicitly requested.

## Install and run

```bash
cd /Users/muthsubr/d/Learnings/DS_ML/Projects/Projects-ML
python3 -m venv .venv
source .venv/bin/activate
pip install -r mcp_scripts/requirements-oracle-mcp.txt
python mcp_scripts/mcp_project_filesystem.py
```

The filesystem server uses the existing MCP dependency. Configure the MCP host
to launch the script with stdio transport. Optionally set
`PROJECT_FILESYSTEM_ROOT` to another existing project directory; the server
will restrict all operations to that root.

## Tools and example arguments

List direct children:

```json
{"path":".","recursive":false}
```

Read a project-relative file:

```json
{"path":"README.md","max_chars":100000}
```

Create a new file (fails if it already exists; parent directory must exist):

```json
{"path":"notes/example.txt","content":"Created through the MCP server.\n"}
```

Edit a unique exact text snippet:

```json
{"path":"README.md","old_text":"old sentence","new_text":"replacement sentence","replace_all":false}
```

There is deliberately no operation to delete a file or directory.