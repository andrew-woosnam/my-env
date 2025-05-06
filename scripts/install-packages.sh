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

SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

LOG_DOMAIN="📦"
source "$REPO_DIR/scripts/lib/log.sh"

log "installing packages ..."

OS_TYPE="$(uname)"

case "$OS_TYPE" in
  Darwin)
    "$REPO_DIR/scripts/macos/macos-packages.sh"
    ;;
  Linux)
    if [[ -f /etc/debian_version ]]; then
      "$REPO_DIR/scripts/linux/debian-packages.sh"
    else
      log "⚠️ Linux detected, but unsupported distribution."
      exit 1
    fi
    ;;
  *)
    log "⚠️ Unsupported OS: $OS_TYPE"
    exit 1
    ;;
esac

log "package installation complete ✓"
