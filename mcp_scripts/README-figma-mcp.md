# Figma MCP Server

**MCP server name:** `figma_api_mcp`  
**Transport:** stdio  
**Script:** `mcp_scripts/mcp_figma_server.py`  

To verify the complete MCP `stdio` handshake and Figma API authentication, configure the environment variables below and run `python mcp_scripts/test_figma_mcp.py`. This smoke test lists the registered tools, checks token authentication via `get_current_user`, and optionally inspects file metadata when `FIGMA_TEST_FILE_KEY` is provided.

The server provides `get_current_user`, `get_file_summary`, `get_file_nodes`, `get_file_comments`, and `export_node_images`. All operations are strictly read-only.

---

## What This Server Performs

1. **Read-Only Design Inspection:** Connects an AI assistant to the Figma REST API (`v1`) so it can inspect pages, frame hierarchies, component properties, comments, and rendered image exports without modifying your Figma files.
2. **Input & Payload Guardrails:**
   * **Strict Validation:** Validates `file_key` and `node_ids` (automatically normalizing URL-style `1-2` node IDs into API-style `1:2` format) before sending requests.
   * **Depth & List Caps:** Restricts tree traversal `depth` to `1–5` and comment lists to `200` items to avoid overwhelming the AI context window.
   * **Credential Isolation:** Reads `FIGMA_ACCESS_TOKEN` exclusively from environment variables—never hardcoded in scripts or config files.

---

## Step-by-Step Local Setup & Usage

### Step 1: Generate a Figma Personal Access Token
1. Open Figma and go to **Settings** -> **Security** -> **Personal access tokens**.
2. Click **Generate new token**, give it a name (e.g., `local-mcp`), select **Read-only** scopes for files/comments, and copy the token.

### Step 2: Create Virtual Environment & Install Packages

**On macOS / Linux (Terminal):**
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r mcp_scripts/requirements-figma-mcp.txt
export FIGMA_ACCESS_TOKEN="figd_your_token_here"
```

**On Windows (PowerShell):**
```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r mcp_scripts\requirements-figma-mcp.txt
$env:FIGMA_ACCESS_TOKEN="figd_your_token_here"
```

### Step 3: Run the Smoke Test
Verify the MCP handshake and Figma token authentication:
```bash
# Optional: include a real Figma file key from a URL (figma.com/design/<FILE_KEY>/...)
export FIGMA_TEST_FILE_KEY="yourFileKey123"
python mcp_scripts/test_figma_mcp.py
```

### Step 4: Register in Your MCP Host JSON Configuration
Add `figma` to your MCP client configuration (use `.venv/bin/python` on macOS/Linux or `.venv\Scripts\python.exe` on Windows):

```json
{
  "mcpServers": {
    "figma": {
      "command": "/path/to/.venv/bin/python",
      "args": ["-u", "/path/to/mcp_scripts/mcp_figma_server.py"],
      "env": {
        "FIGMA_ACCESS_TOKEN": "figd_your_token_here",
        "FIGMA_TIMEOUT_SECONDS": "20"
      }
    }
  }
}
```

### Step 5: Tool Usage Examples (JSON Payloads)

1. **Verify token & account** — `get_current_user`:
   ```json
   {}
   ```

2. **List pages and top-level frames** — `get_file_summary`:
   ```json
   {"file_key": "abc123XYZ789", "depth": 2}
   ```

3. **Inspect specific frame/component layout** — `get_file_nodes`:
   ```json
   {"file_key": "abc123XYZ789", "node_ids": ["1:2", "14:88"], "depth": 3}
   ```

4. **Read design review comments** — `get_file_comments`:
   ```json
   {"file_key": "abc123XYZ789", "limit": 25}
   ```

5. **Render a frame as PNG/SVG** — `export_node_images`:
   ```json
   {"file_key": "abc123XYZ789", "node_ids": ["1:2"], "image_format": "png", "scale": 2.0}
   ```
