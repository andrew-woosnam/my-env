#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# install-brew.sh
#
# Ensures Homebrew is installed and installs packages defined in packages/brew.txt.
# -----------------------------------------------------------------------------

if [[ -z "${REPO_DIR:-}" ]]; then
  echo "❌ REPO_DIR is not set. Run this script via setup.sh or define REPO_DIR manually." >&2
  exit 1
fi
LOG_DOMAIN="📦 [BREW]"
source "$REPO_DIR/scripts/lib/log.sh"

PACKAGE_LIST="$REPO_DIR/packages/brew.txt"

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  log "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  log "Homebrew already installed ✓"
fi

if [[ -f "$PACKAGE_LIST" ]]; then
  while read -r pkg; do
    [[ -z "$pkg" || "$pkg" == \#* ]] && continue
    log "brew install $pkg"
    brew install "$pkg" || log "⚠️ failed to brew install $pkg"
  done < "$PACKAGE_LIST"
else
  log "⚠️ Package list not found at $PACKAGE_LIST"
fi

log "package installation complete ✓"
