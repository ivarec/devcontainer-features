#!/usr/bin/env bash
set -euo pipefail

log() {
    printf '[ripgrep] %s\n' "$*" >&2
}

install_ripgrep() {
    if command -v apt-get >/dev/null 2>&1; then
        export DEBIAN_FRONTEND=noninteractive
        apt-get update -y
        apt-get install -y --no-install-recommends ripgrep
        rm -rf /var/lib/apt/lists/*
        log "The script installed ripgrep with apt-get."
    elif command -v apk >/dev/null 2>&1; then
        apk add --no-cache ripgrep
        log "The script installed ripgrep with apk."
    else
        log "The distribution is not supported. You must use apt-get or apk."
        exit 1
    fi
}

install_ripgrep

if ! command -v rg >/dev/null 2>&1; then
    log "The script did not install ripgrep correctly."
    exit 1
fi

echo "The ripgrep feature is installed."
