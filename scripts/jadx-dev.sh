#!/usr/bin/env bash
# Run jadx developer tools via Gradle (no dist build required).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if [[ $# -eq 0 ]]; then
  exec ./gradlew -q :jadx-cli:jadxDev
fi

# Join args for Gradle -PjadxDevToolArgs
joined="$*"
exec ./gradlew -q :jadx-cli:jadxDev "-PjadxDevToolArgs=${joined}"
