# ivarec's Devcontainer Features

This repository contains a collection of devcontainer features.

## Features

This table shows the available features in this repository.

| Name | URL | Description |
| --- | --- | --- |
| reasonix | [https://reasonix.io](https://reasonix.io) | Installs the Reasonix coding agent toolset. |

### `reasonix`

Run the `reasonix --version` command inside the container to see the version of Reasonix.

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/ivarec/devcontainer-features/reasonix:1": {}
    }
}

```

```bash
reasonix --version

```
