#!/usr/bin/env python3
"""
n8n helper: read a JSON array from stdin, normalize records, add revenue,
and emit a JSON array to stdout. Install pandas only if you extend this script.
"""
import sys, json
from datetime import datetime

records = json.load(sys.stdin)
if not isinstance(records, list):
    raise ValueError("Expected a JSON array on stdin")

cleaned = []
seen = set()
for row in records:
    if not isinstance(row, dict):
        continue
    item = {}
    for key, value in row.items():
        item[str(key).strip()] = value.strip() if isinstance(value, str) else value
    if item.get("quantity") not in (None, "") and item.get("unit_price") not in (None, ""):
        item["revenue"] = float(item["quantity"]) * float(item["unit_price"])
    signature = json.dumps(item, sort_keys=True, default=str)
    if signature not in seen:
        seen.add(signature)
        cleaned.append(item)

json.dump(cleaned, sys.stdout, default=str)
