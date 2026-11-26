# Playwright MCP Server

**MCP server name:** `playwright_browser_mcp`  
**Transport:** stdio  
**Script:** `mcp_scripts/mcp_playwright_server.py`

To verify the complete MCP stdio handshake and Playwright browser execution, configure the optional environment variables below and run `python mcp_scripts/test_playwright_mcp.py`. This smoke test lists the tools, navigates to `https://example.com`, extracts the page heading, and cleanly closes the browser.

The server provides `navigate`, `get_page_text`, `click_element`, `fill_input`, `take_screenshot`, and `close_browser`. Only `http://` and `https://` URLs are permitted, extracted text is capped at 50,000 characters, and screenshots are restricted to a configured output directory.

## What This Server Performs

1. **Transport & Lifecycle:** Runs over `stdio` via `FastMCP` (`playwright_browser_mcp`). The Chromium browser launches lazily only when the first browser tool is called and stays open across tool calls so login sessions or multi-step page flows persist until `close_browser` is called.
2. **Security & Guardrails:**
   * **URL Scheme Restriction:** Blocks `file://`, `javascript:`, and `data:` URIs so the AI cannot read local files through the browser.
   * **Optional Domain Allowlist:** If `PLAYWRIGHT_ALLOWED_DOMAINS` is set, restricts browsing exclusively to approved domains (e.g., `localhost,127.0.0.1,oracle.com`).
   * **Output & Path Caps:** Limits extracted text to `50,000` characters and strips directory paths from screenshot filenames so files only save inside `PLAYWRIGHT_SCREENSHOT_DIR`.

## Install and Run

### Step 1: Create Virtual Environment & Install Packages

**On macOS / Linux (Terminal):**
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r mcp_scripts/requirements-playwright-mcp.txt
playwright install chromium
```

**On Windows (PowerShell):**
```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r mcp_scripts\requirements-playwright-mcp.txt
playwright install chromium
```

### Step 2: Configure Environment Variables (Optional)

Set these variables in your MCP host's server process environment if you want to customize behavior:

| Variable | Default | Purpose |
| :--- | :--- | :--- |
| `PLAYWRIGHT_HEADLESS` | `true` | Set to `false` to watch the browser window open and click in real time. |
| `PLAYWRIGHT_TIMEOUT_MS` | `15000` | Maximum wait time (in milliseconds) for page loads and element selectors. |
| `PLAYWRIGHT_ALLOWED_DOMAINS` | `""` (all HTTP/S) | Comma-separated domain whitelist (e.g., `"example.com,localhost"`). |
| `PLAYWRIGHT_SCREENSHOT_DIR` | `./screenshots` | Local folder where `take_screenshot` saves PNG files. |

### Step 3: Run the Smoke Test

Verify the MCP handshake and Chromium execution locally:
```bash
python mcp_scripts/test_playwright_mcp.py
```

## Tool Usage Examples

1. **Open a webpage** — call `navigate`:
```json
{"url": "https://example.com", "wait_until": "domcontentloaded"}
```

2. **Read page text** — call `get_page_text`:
```json
{"selector": "body", "max_chars": 5000}
```

3. **Type into a form field** — call `fill_input`:
```json
{"selector": "input[name='q']", "value": "Oracle 23ai MCP"}
```

4. **Click a button or link** — call `click_element`:
```json
{"selector": "button[type='submit']"}
```

5. **Capture a screenshot** — call `take_screenshot`:
```json
{"filename": "result.png", "full_page": true}
```

6. **Shut down the browser** — call `close_browser`:
```json
{}
```
