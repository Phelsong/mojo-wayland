#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 Josh S Wilkinson
# Pack: build the C shim + precompiled mojoc into dist/ for release.
# Refuses dev compilers — precompiled artifacts target stable releases only
# (rationale: see README "Packaging").
set -euo pipefail

version=$(mojo --version | awk '{print $2}')
case "$version" in
*dev*)
    echo "refusing to precompile against non-stable Mojo '$version'" >&2
    echo "precompiled artifacts are built against stable releases only" >&2
    echo "switch env to a stable compiler and re-run" >&2
    exit 1
    ;;
esac

# Guard against tampering/edits between stamp and pack.
if grep -q 'version = ".*dev.*"' pixi.toml; then
    echo "pixi.toml still carries a dev version — stamp did not run?" >&2
    exit 1
fi

# Package name comes from pixi.toml; the version was already stamped to the
# compiler's by scripts/update-version.sh (pack depends on it) — re-read
# pixi.toml as the single source of truth for what we are packing.
pkg_name=$(awk -F'"' '/^name = /{print $2; exit}' pixi.toml)
pkg_version=$(awk -F'"' '/^version = /{print $2; exit}' pixi.toml)
if [ "$pkg_version" != "$version" ]; then
    echo "version mismatch: pixi.toml says $pkg_version but compiler is $version" >&2
    echo "run 'pixi run update-version' (or a task that depends on it) first" >&2
    exit 1
fi
# Wayland client library the shim was linked against (dev headers on host).
wayland_version=$(pkg-config --modversion wayland-client)

# Compile target name: conda subdir convention. The build is native —
# the Mojo precompiler cannot cross-compile — so the host triple IS the
# target. x86_64 -> linux-64, aarch64 -> linux-aarch64.
case "$(uname -m)" in
x86_64)  target=linux-64 ;;
aarch64) target=linux-aarch64 ;;
*)
    echo "unsupported compile target: $(uname -m) (expected x86_64 or aarch64)" >&2
    exit 1
    ;;
esac

mkdir -p dist
gcc -shared -fPIC -O2 -Wall -o dist/libwayland_shim.so \
    wayland/c/shim.c wayland/c/generated/xdg-shell-protocol.c \
    -lwayland-client
mojo precompile wayland -I . -o dist/wayland.mojoc
sha256sum dist/wayland.mojoc | awk -F ' ' '{print $1}' > dist/wayland.mojoc.sha256sum

# Release manifest: what this artifact is and what it was built against.
# Each entry is one line: key = value.
{
    echo "name = $pkg_name"
    echo "version = $pkg_version"
    echo "mojo = $version"
    echo "wayland-client = $wayland_version"
    echo "target = $target"
} > dist/version.txt
cp README.md dist/README.md

echo "packed dist/ ($pkg_name $pkg_version, mojo $version, wayland-client $wayland_version, target $target)"