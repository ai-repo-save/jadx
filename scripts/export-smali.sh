#!/usr/bin/env bash
# Export .smali fixtures from APK/DEX for jadx-core integration tests.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$SCRIPT_DIR/jadx-dev.sh" export-smali "$@"
