#!/usr/bin/env bash
# Inspect decompiled output, smali, insns, regions for one method.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$SCRIPT_DIR/jadx-dev.sh" inspect-method "$@"
