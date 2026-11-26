# Git MCP server

This workspace's Git MCP server uses the official `mcp/git` Docker image and
exposes Git operations for the repository at
`/Users/muthsubr/d/Learnings/DS_ML/Projects/Projects-ML`.

## Install

Docker Desktop (or another working Docker engine) must be running. The image has
been installed locally with:

```bash
docker pull mcp/git:latest
```

## Connect an MCP client

Import or copy the `mcpServers` entry in `git-mcp.json` into the configuration
used by your MCP-compatible client. The configuration starts the container in
stdio mode and mounts only this project repository at `/workspace`; it does not
mount the rest of your home directory. Keep Docker running while using the
server. Since the image uses the mutable `latest` tag, refresh it when desired
with `docker pull mcp/git:latest`.

## Capabilities and safety

The server provides Git repository operations such as status, diffs, log,
branches, commit, fetch, pull, and push. Use the MCP client's tool list to see
the precise tools supported by the installed image. Git actions can change
repository state or publish commits, so inspect diffs/status and confirm intent
before committing or pushing. Git history is available through the log and
show/revision tools; use a restore/checkout operation carefully to avoid
discarding uncommitted changes.

Remote operations use this repository's existing Git remote configuration and
credentials. For GitHub, configure SSH keys or a credential manager on the host
and ensure the remote URL is reachable; the MCP server does not create GitHub
credentials or grant repository access on its own. No token is stored in this
folder or the MCP configuration.

The JSON file contains an absolute macOS path for this machine. Update the
`src=` mount path if the repository is moved or the configuration is used on a
different computer.