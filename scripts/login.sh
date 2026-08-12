#!/data/data/com.termux/files/usr/bin/bash
# Login helper for EvoluX Mobile
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ALIAS="evolux"
if [ -f "$ROOT/.local/distro-alias" ]; then
  ALIAS="$(cat "$ROOT/.local/distro-alias")"
fi
if ! command -v proot-distro >/dev/null 2>&1; then
  echo "proot-distro not found. Run: pkg install proot-distro"
  exit 1
fi
exec proot-distro login "$ALIAS" "$@"
