#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# install-apt.sh
#
# Installs APT packages defined in packages/apt.txt on Debian/Ubuntu systems.
# -----------------------------------------------------------------------------

if [[ -z "${REPO_DIR:-}" ]]; then
  echo "❌ REPO_DIR is not set. Run this script via setup.sh or define REPO_DIR manually." >&2
  exit 1
fi
LOG_DOMAIN="📦 [APT]"
source "$REPO_DIR/scripts/lib/log.sh"

PACKAGE_LIST="$REPO_DIR/packages/apt.txt"

log "updating package index ..."
sudo apt-get update -y

if [[ -f "$PACKAGE_LIST" ]]; then
  while read -r pkg; do
    [[ -z "$pkg" || "$pkg" == \#* ]] && continue
    log "apt install $pkg"
    sudo apt-get install -y "$pkg" || log "⚠️ failed to apt install $pkg"
  done < "$PACKAGE_LIST"
else
  log "⚠️ Package list not found at $PACKAGE_LIST"
fi

log "apt package installation complete ✓"
