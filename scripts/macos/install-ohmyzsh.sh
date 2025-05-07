#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# install-ohmyzsh.sh
#
# Installs Oh My Zsh to ~/.oh-my-zsh if not already present.
# Prevents OMZ from replacing .zshrc.
# Fails softly if install can't proceed (e.g., no network or perms).
# -----------------------------------------------------------------------------

# Resolve repo root and logger
SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOG_DOMAIN="📦 [OMZ]"
source "$REPO_DIR/scripts/lib/log.sh"

log "checking for Oh My Zsh ..."

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  log "installing Oh My Zsh ..."
  
  RUNZSH=no KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
      log "⚠️ Failed to install Oh My Zsh. Continuing without it."
      return 0
    }

  log "Oh My Zsh installation complete ✓"
else
  log "Oh My Zsh already installed ✓"
fi
