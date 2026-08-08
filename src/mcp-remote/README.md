# MCP Remote Dev Container Feature

This feature installs the `mcp-remote` CLI via npm. Post-install scripts are disabled (`--ignore-scripts`) for safety.

This feature depends on Node.js (LTS). The script installs `mcp-remote` globally so the `mcp-remote` command is available on `PATH`.

## Usage

Add this code to your `.devcontainer/devcontainer.json` file.

```jsonc
{
  "features": {
    "ghcr.io/ivarec/devcontainer-features/mcp-remote:0": {
      "version": "0.1.38"
    }
  }
}
```

Change `0.1.38` to a specific version number, or use `latest` to install the newest npm release.

## Options

| Option | Default | Description |
| --- | --- | --- |
| `version` | `0.1.38` | The mcp-remote version to install. Use `latest` for the newest npm release. |
