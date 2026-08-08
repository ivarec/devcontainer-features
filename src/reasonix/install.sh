#!/usr/bin/env bash
set -euo pipefail

REASONIX_VERSION="${VERSION:-latest}"
INSTALL_DESKTOP="${DESKTOP:-true}"

log() {
    printf '[reasonix] %s\n' "$*" >&2
}

install_packages() {
    if command -v apt-get >/dev/null 2>&1; then
        export DEBIAN_FRONTEND=noninteractive
        apt-get update -y
        local pkgs="ca-certificates curl tar"
        if [ "${INSTALL_DESKTOP}" = "true" ]; then
            pkgs="${pkgs} libwebkit2gtk-4.1-0 libgtk-3-0 libgdk-pixbuf-2.0-0 libsoup-3.0-0 libglib2.0-0 libjavascriptcoregtk-4.1-0 libwayland-client0 libwayland-egl1 libgl1-mesa-dri libegl1-mesa"
        fi
        # shellcheck disable=SC2086
        apt-get install -y --no-install-recommends ${pkgs}
        rm -rf /var/lib/apt/lists/*
    elif command -v apk >/dev/null 2>&1; then
        local pkgs="ca-certificates curl tar"
        if [ "${INSTALL_DESKTOP}" = "true" ]; then
            pkgs="${pkgs} webkit2gtk-4.1 gtk+3.0 gdk-pixbuf libsoup3 glib wayland-libs-client wayland-libs-egl mesa-dri-gallium"
        fi
        # shellcheck disable=SC2086
        apk add --no-cache ${pkgs}
    else
        log "Unsupported distribution. apt-get or apk is required."
        exit 1
    fi
}

detect_target_platform() {
    local os_name arch_name

    if [ -n "${TARGETPLATFORM:-}" ]; then
        printf '%s' "$TARGETPLATFORM"
        return
    fi

    os_name="$(uname -s | tr '[:upper:]' '[:lower:]')"
    if command -v dpkg >/dev/null 2>&1; then
        arch_name="$(dpkg --print-architecture)"
    else
        arch_name="$(uname -m)"
    fi

    case "$arch_name" in
        amd64|x86_64)
            arch_name="amd64"
            ;;
        arm64|aarch64)
            arch_name="arm64"
            ;;
        *)
            log "Unsupported architecture: $arch_name"
            exit 1
            ;;
    esac

    printf '%s/%s' "$os_name" "$arch_name"
}

reasonix_asset_suffix() {
    case "$TARGETPLATFORM" in
        linux/amd64)
            printf 'linux-amd64'
            ;;
        linux/arm64)
            printf 'linux-arm64'
            ;;
        *)
            log "Unsupported platform: $TARGETPLATFORM"
            exit 1
            ;;
    esac
}

install_reasonix() {
    local asset_suffix reasonix_tarball release_url tmp_dir

    if [ "${REASONIX_VERSION}" = "latest" ]; then
        REASONIX_VERSION="1.21.3"
        log "Changed 'latest' to version ${REASONIX_VERSION}."
    fi

    TARGETPLATFORM="$(detect_target_platform)"
    asset_suffix="$(reasonix_asset_suffix)"
    reasonix_tarball="Reasonix-${asset_suffix}.tar.gz"
    release_url="https://dl.reasonix.io/desktop-v${REASONIX_VERSION}"
    
    tmp_dir="$(mktemp -d)"
    trap 'rm -rf "$tmp_dir"' EXIT

    log "Downloading ${reasonix_tarball}"
    curl --fail --show-error --location "${release_url}/${reasonix_tarball}" -o "${tmp_dir}/${reasonix_tarball}"

    log "Installing Reasonix"
    tar --no-same-owner -C "$tmp_dir" -xzf "${tmp_dir}/${reasonix_tarball}"
    
    install -m 0755 "${tmp_dir}/reasonix" /usr/local/bin/reasonix
    if [ "${INSTALL_DESKTOP}" = "true" ]; then
        install -m 0755 "${tmp_dir}/reasonix-desktop" /usr/local/bin/reasonix-desktop
        install -m 0755 "${tmp_dir}/reasonix-launcher" /usr/local/bin/reasonix-launcher
        log "Installed reasonix, reasonix-desktop, and reasonix-launcher"
    else
        log "Skipped reasonix-desktop and reasonix-launcher (desktop=false)"
    fi

    rm -rf "$tmp_dir"
    trap - EXIT
}

install_packages
install_reasonix

if ! command -v reasonix >/dev/null 2>&1; then
    log "The script did not install reasonix correctly."
    exit 1
fi

echo "The reasonix feature is installed."