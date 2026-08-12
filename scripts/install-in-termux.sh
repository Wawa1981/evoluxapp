#!/data/data/com.termux/files/usr/bin/bash
# EvoluX Mobile installer — run FROM Termux (not from a PC chroot).
# Same idea as installing Kali/Debian with proot-distro, then branding EvoluX.
set -euo pipefail

RED='\033[0;31m'
GRN='\033[0;32m'
YLW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GRN}==>${NC} $*"; }
warn() { echo -e "${YLW}warning:${NC} $*"; }
die()  { echo -e "${RED}error:${NC} $*"; exit 1; }

# Resolve repo root (directory containing this script's parent)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Must look like Termux
if [ -z "${PREFIX:-}" ] || [[ "$PREFIX" != *com.termux* && "$PREFIX" != *termux* ]]; then
  if [ ! -d /data/data/com.termux/files/usr ]; then
    warn "This script is meant to run inside Termux on Android."
    warn "On a PC you only need this repo as source; install happens on the phone."
  fi
fi

info "EvoluX Mobile installer"
info "Repo root: $ROOT"

# Architecture
ARCH="$(uname -m)"
case "$ARCH" in
  aarch64|arm64) info "Architecture: $ARCH (OK)" ;;
  *)
    warn "Architecture is $ARCH — EvoluX Mobile v1 targets aarch64."
    warn "Continuing anyway; package availability may differ."
    ;;
esac

info "Updating Termux packages..."
pkg update -y
pkg install -y proot-distro git curl

# Install Debian base (official proot-distro plugin)
ALIAS="evolux"
BASE="debian"

if proot-distro list 2>/dev/null | grep -qE "^${ALIAS}[[:space:]]"; then
  info "Distro alias '$ALIAS' already installed."
elif proot-distro list 2>/dev/null | grep -qE "^${BASE}[[:space:]]"; then
  info "Base '$BASE' already installed."
  # Try rename to evolux if supported
  if proot-distro help 2>&1 | grep -q rename; then
    info "Renaming $BASE -> $ALIAS"
    proot-distro rename "$BASE" "$ALIAS" || ALIAS="$BASE"
  else
    warn "Could not rename; will use '$BASE' as EvoluX environment."
    ALIAS="$BASE"
  fi
else
  info "Installing proot-distro base: $BASE (first time can take a while)..."
  proot-distro install "$BASE"
  if proot-distro help 2>&1 | grep -q rename; then
    info "Renaming $BASE -> $ALIAS"
    proot-distro rename "$BASE" "$ALIAS" 2>/dev/null || {
      # fallback: some versions use --override-alias at install
      ALIAS="$BASE"
      warn "Rename failed; using alias '$ALIAS'."
    }
  else
    # Try install with override if re-install needed — keep debian
    ALIAS="$BASE"
    warn "proot-distro has no rename; login with: proot-distro login $ALIAS"
    warn "(EvoluX branding still applies inside.)"
  fi
fi

# Detect final installed name
if proot-distro list 2>/dev/null | grep -qE "^evolux[[:space:]]"; then
  ALIAS="evolux"
elif proot-distro list 2>/dev/null | grep -qE "^debian[[:space:]]"; then
  ALIAS="debian"
fi

info "Using distro alias: $ALIAS"

# Copy bootstrap payload into proot via bind
info "Running EvoluX post-install inside $ALIAS..."
proot-distro login "$ALIAS" --shared-tmp --bind "$ROOT:/evoluxapp:ro" -- bash -lc '
  set -e
  cp /evoluxapp/branding/motd /root/evolux-motd
  cp /evoluxapp/bootstrap/packages.txt /tmp/evolux-packages.txt
  bash /evoluxapp/bootstrap/post-install.sh /tmp/evolux-packages.txt
'

# Save preferred alias for login helper
mkdir -p "$ROOT/.local"
echo "$ALIAS" > "$ROOT/.local/distro-alias"

info "Done."
echo
echo "  Login:   proot-distro login $ALIAS"
echo "  Or:      bash $ROOT/scripts/login.sh"
echo "  Inside:  evolux-welcome"
echo
echo "  PC ISO:  https://github.com/Wawa1981/evolux"
echo "  Mobile:  https://github.com/Wawa1981/evoluxapp"
echo
