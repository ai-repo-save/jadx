#!/usr/bin/env bash
# Dump method CFG (.dot) for debugging decompiler passes.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$SCRIPT_DIR/jadx-dev.sh" dump-cfg "$@"
