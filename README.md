# Ivarec's Devcontainer Features

This repository contains a collection of devcontainer features.

## Features

This table shows the available features in this repository.

| Name | URL | Description |
| --- | --- | --- |
| reasonix | [https://reasonix.io](https://reasonix.io) | Installs the Reasonix coding agent toolset. |
| ripgrep | [https://github.com/BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep) | Installs the ripgrep search tool. |
| mcp-remote | [https://github.com/ivarec/mcp-remote](https://github.com/ivarec/mcp-remote) | Installs the mcp-remote CLI via npm. |

### `reasonix`

Run the `reasonix --version` command inside the container to see the version of Reasonix.

```jsonc
{
    "image": "[mcr.microsoft.com/devcontainers/base:ubuntu](https://mcr.microsoft.com/devcontainers/base:ubuntu)",
    "features": {
        "ghcr.io/ivarec/devcontainer-features/reasonix:1": {}
    }
}

```

```bash
reasonix --version

```

### `ripgrep`

Run the `rg --version` command inside the container to see the version of ripgrep.

```jsonc
{
    "image": "[mcr.microsoft.com/devcontainers/base:ubuntu](https://mcr.microsoft.com/devcontainers/base:ubuntu)",
    "features": {
        "ghcr.io/ivarec/devcontainer-features/ripgrep:1": {}
    }
}

```

```bash
rg --version

```

### `mcp-remote`

Run the `mcp-remote --version` command inside the container to see the version of mcp-remote.

```jsonc
{
    "image": "[mcr.microsoft.com/devcontainers/base:ubuntu](https://mcr.microsoft.com/devcontainers/base:ubuntu)",
    "features": {
        "ghcr.io/ivarec/devcontainer-features/mcp-remote:0": {}
    }
}

```

```bash
mcp-remote --version

```
