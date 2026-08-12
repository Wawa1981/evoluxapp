#!/usr/bin/env bash
# Runs INSIDE the proot distro as root after first install.
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "==> EvoluX Mobile post-install"

# Branding
echo "evolux" > /etc/hostname
if [ -f /etc/os-release ]; then
  # Keep ID=debian for apt compatibility; set pretty name
  if ! grep -q 'EvoluX Mobile' /etc/os-release 2>/dev/null; then
    sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="EvoluX Mobile (Debian proot)"/' /etc/os-release || true
  fi
fi

# MOTD
if [ -f /tmp/evolux-branding/motd ]; then
  cp /tmp/evolux-branding/motd /etc/motd
elif [ -f /root/evolux-motd ]; then
  cp /root/evolux-motd /etc/motd
fi

# Welcome helper
cat > /usr/local/bin/evolux-welcome << 'EOS'
#!/usr/bin/env bash
cat <<'EOF'

  EvoluX Mobile — quick map
  =========================
  Finance CLI :  ledger   |  qalc
  Security    :  gpg  pass  tor
  Python      :  python3  pip3
  Update      :  apt update && apt upgrade

  PC ISO (x86_64, DistroWatch path):
    https://github.com/Wawa1981/evolux

  Mobile kit:
    https://github.com/Wawa1981/evoluxapp

EOF
EOS
chmod 755 /usr/local/bin/evolux-welcome

# Locales (quiet fail ok)
apt-get update -y
apt-get install -y locales || true
sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen 2>/dev/null || true
sed -i 's/^# *fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen 2>/dev/null || true
locale-gen || true

# Packages list
PKG_FILE="${1:-/tmp/evolux-packages.txt}"
if [ -f "$PKG_FILE" ]; then
  mapfile -t PKGS < <(grep -vE '^\s*(#|$)' "$PKG_FILE" || true)
  if [ "${#PKGS[@]}" -gt 0 ]; then
    echo "==> Installing ${#PKGS[@]} packages..."
    apt-get install -y "${PKGS[@]}" || {
      echo "==> Some packages failed; retrying one by one..."
      for p in "${PKGS[@]}"; do
        apt-get install -y "$p" || echo "skip: $p"
      done
    }
  fi
else
  echo "==> No packages file at $PKG_FILE — installing minimal set"
  apt-get install -y curl git vim htop python3 gnupg ledger qalc || true
fi

apt-get clean || true

echo "==> EvoluX Mobile ready. Run: evolux-welcome"
