#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# install-npm.sh
#
# Ensures Node.js and npm are available (via Homebrew).
# Installs global npm packages listed in packages/npm.txt.
# Skips gracefully if installation is not possible.
# -----------------------------------------------------------------------------

# Resolve repo root and logger
SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOG_DOMAIN="📦 [NPM]"
source "$REPO_DIR/scripts/lib/log.sh"

PACKAGE_LIST="$REPO_DIR/packages/npm.txt"

# Ensure npm (and node) is installed
if ! command -v npm &>/dev/null; then
  log "npm not found. Attempting install via Homebrew..."

  if command -v brew &>/dev/null; then
    brew install node || {
      log "⚠️ Failed to install node/npm via Homebrew. Skipping npm packages."
      exit 0  # Changed from return 0
    }
  else
    log "⚠️ Homebrew not available. Cannot install npm. Skipping."
    exit 0  # Changed from return 0
  fi
else
  log "npm already installed ✓"
fi

# Install packages from npm.txt
if [[ -f "$PACKAGE_LIST" ]]; then
  while read -r pkg; do
    [[ -z "$pkg" || "$pkg" == \#* ]] && continue
    log "npm install -g $pkg"
    npm install -g "$pkg" || log "⚠️ Failed to npm install $pkg"
  done < "$PACKAGE_LIST"
else
  log "⚠️ Package list not found at $PACKAGE_LIST"
fi

log "npm package installation complete ✓"