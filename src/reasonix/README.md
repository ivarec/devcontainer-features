# Reasonix Dev Container Feature

This feature installs the Reasonix coding agent tools into the `/usr/local/bin` directory. These tools include `reasonix`, `reasonix-desktop`, and `reasonix-launcher`.

This feature supports Debian, Ubuntu, and Alpine base images. The script downloads the correct Linux release file for your system architecture.

## Usage

Add the feature to your `.devcontainer/devcontainer.json` file.

```jsonc
{
  "features": {
    "ghcr.io/ivarec/devcontainer-features/reasonix:1": {
      "version": "latest"
    }
  }
}

```

Change `latest` to a specific version number. For example, use `1.21.3` to install a specific release.

To install only the CLI tools without the graphical `reasonix-desktop` client and its system dependencies:

```jsonc
{
  "features": {
    "ghcr.io/ivarec/devcontainer-features/reasonix:1": {
      "version": "latest",
      "desktop": false
    }
  }
}
```

## Graphical Interface Configuration (Wayland and X11)

The `reasonix-desktop` tool is a graphical application. A devcontainer cannot show graphical applications by default. You must configure the container to access the display server of your host computer.

Add these `runArgs` to your `devcontainer.json` file to support Wayland and X11:

```jsonc
{
  "runArgs": [
    "--volume=/tmp/.X11-unix:/tmp/.X11-unix",
    "--env=DISPLAY=${env:DISPLAY}",
    "--volume=${env:XDG_RUNTIME_DIR}/${env:WAYLAND_DISPLAY}:${env:XDG_RUNTIME_DIR}/${env:WAYLAND_DISPLAY}",
    "--env=WAYLAND_DISPLAY=${env:WAYLAND_DISPLAY}",
    "--env=XDG_RUNTIME_DIR=${env:XDG_RUNTIME_DIR}",
    "--device=/dev/dri:/dev/dri"
  ]
}

```

Your host computer must set the `DISPLAY`, `WAYLAND_DISPLAY`, and `XDG_RUNTIME_DIR` environment variables. The `--device=/dev/dri:/dev/dri` argument gives hardware acceleration to the container.

## Options

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `version` | `string` | `latest` | The Reasonix version to install. Use `latest` to install the most recent release. |
| `desktop` | `boolean` | `true` | Install the `reasonix-desktop` graphical client and its system dependencies (libwebkit2gtk, libgtk-3, libsoup-3.0, etc.). Set to `false` for headless/CLI-only environments where the graphical client is not needed. |
