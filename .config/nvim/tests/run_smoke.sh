#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
SMOKE_ROOT=$(mktemp -d)
trap 'rm -rf "$SMOKE_ROOT"' EXIT

PATH="$HOME/.local/share/nvim/mason/bin:/usr/local/go/bin:$PATH" \
NVIM_SMOKE_ROOT="$SMOKE_ROOT" \
nvim --headless \
  '+lua require("tests.smoke").run()' \
  '+qa'
