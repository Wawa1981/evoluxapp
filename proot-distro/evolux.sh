# shellcheck shell=bash
# Optional proot-distro plugin fragment for EvoluX Mobile.
#
# proot-distro official plugins ship with the package. Custom plugins
# are often installed under:  $PREFIX/etc/proot-distro/
#
# EvoluX Mobile v1 does NOT ship its own multi-GB rootfs tarball.
# The installer (scripts/install-in-termux.sh) uses the official
# "debian" plugin, then brands + packages as EvoluX.
#
# If you later host a custom aarch64 rootfs, fill in:
#
# DISTRO_NAME="EvoluX Mobile"
# DISTRO_COMMENT="Finance toolkit (Debian base, proot)"
# TARBALL_URL['aarch64']="https://example.com/evolux-aarch64.tar.xz"
# TARBALL_SHA256['aarch64']="..."
#
# Until then, prefer:  bash scripts/install-in-termux.sh

DISTRO_NAME="EvoluX Mobile"
DISTRO_COMMENT="Finance-oriented proot environment (see install-in-termux.sh; uses Debian base)"
