#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 Josh S Wilkinson
# Stamp the project version to match the Mojo compiler in use.
#
# Runs FIRST in the release pipeline (build and pack both depend on it):
# the version being packed IS the compiler version being packed against,
# so it must be written before anything consumes it — the mojoc, the conda
# recipe, and the release manifest all read these files downstream.
#
# Policy (see README "Packaging"): releases target STABLE Mojo compilers.
# A dev/nightly compiler does not stamp and does not block the dev flow —
# it skips silently, leaving the checked-in version untouched. Only
# `pack` (which refuses dev compilers anyway) needs the stamp to be real.
set -euo pipefail

version=$(mojo --version | awk '{print $2}')
case "$version" in
*dev*)
    echo "compiler $version is a dev build — skipping version stamp" >&2
    exit 0
    ;;
esac

# Stamp ONLY the [project].version and [package].version lines. The third
# column-0 `version = ...` in pixi.toml is the [package.build.backend]
# version SPEC (a range like >=0.2.7) and must never be touched. Rather
# than counting occurrences, anchor each stamp to the preceding
# `name = "mojo-wayland"` line, which uniquely introduces both sections.
# (A bare /^version = / regex matches all three — this bit us once.)
sed -i "/^name = \"mojo-wayland\"/{N; s/version = \".*\"/version = \"$version\"/}" pixi.toml
sed -i "s/^  version: \".*\"/  version: \"$version\"/" tests/recipe.yaml

echo "stamped version $version (pixi.toml project+package, tests/recipe.yaml)"