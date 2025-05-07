#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# install-brew.sh
#
# Installs Homebrew (if missing) and installs packages listed in packages/brew.txt.
# Skips installation if Homebrew is not writable due to missing admin privileges.
# -----------------------------------------------------------------------------

# Resolve repo root and logger
SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOG_DOMAIN="📦 [BREW]"
source "$REPO_DIR/scripts/lib/log.sh"

PACKAGE_LIST="$REPO_DIR/packages/brew.txt"

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
  log "Homebrew not found."

  # Determine expected install location based on architecture
  BREW_PREFIX="/opt/homebrew"
  [[ "$(uname -m)" == "i386" ]] && BREW_PREFIX="/usr/local"

  # If the user can't write to the install dir, skip Homebrew
  if [[ ! -w "$BREW_PREFIX" ]]; then
    log "⚠️ No write access to $BREW_PREFIX. Skipping Homebrew install."
    return 0
  fi

  # Attempt installation
  log "Installing Homebrew ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
    log "⚠️ Homebrew install failed. Continuing without it."
    return 0
  }
else
  log "Homebrew already installed ✓"
fi

# Install packages from brew.txt
if [[ -f "$PACKAGE_LIST" ]]; then
  while read -r pkg; do
    [[ -z "$pkg" || "$pkg" == \#* ]] && continue
    log "brew install $pkg"
    brew install "$pkg" || log "⚠️ Failed to install $pkg"
  done < "$PACKAGE_LIST"
else
  log "⚠️ Package list not found at $PACKAGE_LIST"
fi

log "brew package installation complete ✓"
