#!/usr/bin/env bash
set -euo pipefail

MCP_REMOTE_VERSION="${VERSION:-0.1.38}"

log() {
    printf '[mcp-remote] %s\n' "$*" >&2
}

log "Installing mcp-remote ${MCP_REMOTE_VERSION}"
npm install -g --ignore-scripts --loglevel=info "mcp-remote@${MCP_REMOTE_VERSION}"

if ! command -v mcp-remote >/dev/null 2>&1; then
    log "The script did not install mcp-remote correctly."
    exit 1
fi

echo "The mcp-remote feature is installed."
