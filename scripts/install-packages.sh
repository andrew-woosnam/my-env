#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# install-packages.sh
#
# Top-level entrypoint for installing globally used package managers and their
# associated packages. Delegates to a platform-specific install script, which
# further delegates to one script per package manager (e.g., brew, npm, pnpm).
#
# Each package manager's script handles:
# - Ensuring the package manager is available
# - Reading a curated list of packages from packages/*.txt
# - Installing the listed packages
# -----------------------------------------------------------------------------

echo "🎛️ 📦 installing packages ..."

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OS_TYPE="$(uname)"

case "$OS_TYPE" in
  Darwin)
    "$REPO_DIR/scripts/macos/macos-packages.sh"
    ;;
  Linux)
    if [[ -f /etc/debian_version ]]; then
      "$REPO_DIR/scripts/linux/debian-packages.sh"
    else
      echo "🎛️ 📦 ⚠️ Linux detected, but unsupported distribution."
      exit 1
    fi
    ;;
  *)
    echo "🎛️ 📦 ⚠️ Unsupported OS: $OS_TYPE"
    exit 1
    ;;
esac

echo "🎛️ 📦 package installation complete ✓"
