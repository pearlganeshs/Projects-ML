Included workflow components
Pipeline stage	Included nodes
Data sources	Excel, Oracle DB, Python random data
Dataset creation	Merge Node (3 inputs)
Data cleaning	Code Node
Basic exploration	Code Node (EDA summary)
Local AI	Ollama HTTP Request – Qwen3:14b
Pattern identification	Python Execute Command
BI integration	Metabase API placeholder

Before executing on your Mac
1. Import the JSON into your self-hosted n8n instance.
2. Configure Oracle DB credentials.
3. Mount your Excel input and Python scripts into the n8n container.
4. Ensure Ollama is running on port 11434 on macOS.
5. Configure Metabase API authentication and the actual BI query.
Important: This is a starter workflow, not a completely production-ready implementation. The Python scripts, Oracle credentials, data persistence between Python stages, and Metabase/Wren AI/Slack integrations require configuration. The pattern-detection node expects a Python script to be supplied.

I recommend validating the Excel → Oracle → Python → Merge → Cleaning → Ollama stages first, then adding Isolation Forest, Oracle OML4SQL, Wren AI, Metabase dashboards and Slack notifications.