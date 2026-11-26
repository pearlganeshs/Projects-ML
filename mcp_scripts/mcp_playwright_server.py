"""Playwright MCP server with safe, controlled browser automation tools."""

import os
from pathlib import Path
from typing import Any
from urllib.parse import urlparse

from mcp.server.fastmcp import FastMCP
from playwright.async_api import Browser, BrowserContext, Page, Playwright, async_playwright

mcp = FastMCP("playwright_browser_mcp")

_HEADLESS = os.environ.get("PLAYWRIGHT_HEADLESS", "true").lower() in {"true", "1", "yes"}
_TIMEOUT_MS = int(os.environ.get("PLAYWRIGHT_TIMEOUT_MS", "15000"))
_MAX_TEXT_CHARS = 50_000

# Optional comma-separated allowlist (e.g., "example.com,localhost,127.0.0.1")
_RAW_DOMAINS = os.environ.get("PLAYWRIGHT_ALLOWED_DOMAINS", "").strip()
_ALLOWED_DOMAINS = {d.strip().lower() for d in _RAW_DOMAINS.split(",") if d.strip()}

# Directory for saving screenshots safely inside the project
_SCREENSHOT_DIR = Path(
    os.environ.get(
        "PLAYWRIGHT_SCREENSHOT_DIR",
        str(Path(__file__).resolve().parent.parent / "screenshots"),
    )
).resolve()

_pw: Playwright | None = None
_browser: Browser | None = None
_context: BrowserContext | None = None
_page: Page | None = None


def _validate_url(url: str) -> str:
    """Ensure only http/https URLs are visited and enforce optional domain allowlist."""
    parsed = urlparse(url)
    if parsed.scheme not in {"http", "https"}:
        raise ValueError("Only http:// and https:// URLs are allowed.")
    hostname = (parsed.hostname or "").lower()
    if not hostname:
        raise ValueError("URL must contain a valid hostname.")
    if _ALLOWED_DOMAINS:
        if not any(hostname == d or hostname.endswith("." + d) for d in _ALLOWED_DOMAINS):
            raise ValueError(f"Domain '{hostname}' is not in PLAYWRIGHT_ALLOWED_DOMAINS.")
    return url


async def _get_page() -> Page:
    """Lazily initialize and return a single active browser page."""
    global _pw, _browser, _context, _page
    if _page is not None and not _page.is_closed():
        return _page

    _pw = await async_playwright().start()
    _browser = await _pw.chromium.launch(headless=_HEADLESS)
    _context = await _browser.new_context(viewport={"width": 1280, "height": 800})
    _page = await _context.new_page()
    _page.set_default_timeout(_TIMEOUT_MS)
    return _page


@mcp.tool()
async def navigate(url: str, wait_until: str = "domcontentloaded") -> dict[str, Any]:
    """Navigate to an HTTP/HTTPS URL and return the page title and final URL."""
    if wait_until not in {"load", "domcontentloaded", "networkidle", "commit"}:
        raise ValueError("Invalid wait_until value.")
    safe_url = _validate_url(url)
    page = await _get_page()
    response = await page.goto(safe_url, wait_until=wait_until)
    return {
        "url": page.url,
        "title": await page.title(),
        "status": response.status if response else None,
    }


@mcp.tool()
async def get_page_text(selector: str = "body", max_chars: int = 20_000) -> dict[str, Any]:
    """Extract visible text from the current page or a specific CSS selector."""
    if not 1 <= max_chars <= _MAX_TEXT_CHARS:
        raise ValueError(f"max_chars must be between 1 and {_MAX_TEXT_CHARS}")
    page = await _get_page()
    text = await page.locator(selector).inner_text()
    truncated = len(text) > max_chars
    return {
        "url": page.url,
        "selector": selector,
        "text": text[:max_chars],
        "truncated": truncated,
    }


@mcp.tool()
async def click_element(selector: str) -> dict[str, str]:
    """Click an element matching a CSS or Playwright selector."""
    page = await _get_page()
    await page.locator(selector).first.click()
    return {"clicked": selector, "current_url": page.url}


@mcp.tool()
async def fill_input(selector: str, value: str) -> dict[str, str]:
    """Fill a text input or textarea matching a selector."""
    page = await _get_page()
    await page.locator(selector).first.fill(value)
    return {"filled": selector, "current_url": page.url}


@mcp.tool()
async def take_screenshot(filename: str = "capture.png", full_page: bool = False) -> dict[str, str]:
    """Save a PNG screenshot inside the configured screenshot directory."""
    safe_name = Path(filename).name
    if not safe_name.endswith(".png"):
        safe_name += ".png"
    _SCREENSHOT_DIR.mkdir(parents=True, exist_ok=True)
    target = (_SCREENSHOT_DIR / safe_name).resolve()
    target.relative_to(_SCREENSHOT_DIR)

    page = await _get_page()
    await page.screenshot(path=str(target), full_page=full_page)
    return {"saved_to": str(target), "url": page.url}


@mcp.tool()
async def close_browser() -> dict[str, str]:
    """Close the active browser session and free system memory."""
    global _pw, _browser, _context, _page
    if _browser:
        await _browser.close()
    if _pw:
        await _pw.stop()
    _pw = _browser = _context = _page = None
    return {"status": "closed"}


if __name__ == "__main__":
    mcp.run(transport="stdio")
