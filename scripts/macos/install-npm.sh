#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# install-npm.sh
#
# Ensures Node.js and npm are installed (via Homebrew),
# then installs global npm packages defined in packages/npm.txt.
# -----------------------------------------------------------------------------

if [[ -z "${REPO_DIR:-}" ]]; then
  echo "❌ REPO_DIR is not set. Run this script via setup.sh or define REPO_DIR manually." >&2
  exit 1
fi
LOG_DOMAIN="📦 [NPM]"
source "$REPO_DIR/scripts/lib/log.sh"

PACKAGE_LIST="$REPO_DIR/packages/npm.txt"

# Ensure Node.js and npm are installed
if ! command -v npm &>/dev/null; then
  log "npm not found. Installing via Homebrew..."
  brew install node
else
  log "npm already installed ✓"
fi

# Install packages
if [[ -f "$PACKAGE_LIST" ]]; then
  while read -r pkg; do
    [[ -z "$pkg" || "$pkg" == \#* ]] && continue
    log "npm install -g $pkg"
    npm install -g "$pkg" || log "⚠️ failed to npm install $pkg"
  done < "$PACKAGE_LIST"
else
  log "⚠️ Package list not found at $PACKAGE_LIST"
fi

log "package installation complete ✓"
