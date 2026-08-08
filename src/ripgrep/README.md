# Ripgrep Dev Container Feature

This feature installs the ripgrep tool into the `/usr/local/bin` directory.

This feature supports Debian, Ubuntu, and Alpine base images. The script downloads the correct Linux release file for your system architecture.

## Usage

Add this code to your `.devcontainer/devcontainer.json` file.

```jsonc
{
  "features": {
    "ghcr.io/ivarec/devcontainer-features/ripgrep:1": {
      "version": "latest"
    }
  }
}

```

Change `latest` to a specific version number. For example, use `14.1.0` to install a specific release.

## Options

| Option | Default | Description |
| --- | --- | --- |
| `version` | `latest` | The ripgrep version to install. Use `latest` to install the newest release. |

