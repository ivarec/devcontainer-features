# Reasonix Dev Container Feature

This feature installs the Reasonix coding agent tools into the `/usr/local/bin` directory. These tools include `reasonix`, `reasonix-desktop`, and `reasonix-launcher`.

It supports Debian, Ubuntu, and Alpine base images. The script downloads the correct Linux release file for your system architecture.

## Usage

Add the feature to your `.devcontainer/devcontainer.json` file.

```jsonc
{
  "features": {
    "ghcr.io/ivarec/devcontainer-features/reasonix:1": {
      "reasonixVersion": "latest"
    }
  }
}

```

Change `latest` to a specific version number, for example, `1.21.3`, to install a specific release.

## Options

| Option | Default | Description |
| --- | --- | --- |
| `reasonixVersion` | `latest` | The Reasonix version to install. Use `latest` to install the most recent release. |
