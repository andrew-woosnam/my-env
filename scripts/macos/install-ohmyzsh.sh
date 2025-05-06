#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# install-ohmyzsh.sh
#
# Installs Oh My Zsh to ~/.oh-my-zsh if not already installed.
# Skips shell change and default zshrc overwrite.
# -----------------------------------------------------------------------------

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
LOG_DOMAIN="📦 [OMZ]"
source "$REPO_DIR/scripts/lib/log.sh"

log "checking for Oh My Zsh ..."

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  log "installing Oh My Zsh ..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  log "Oh My Zsh installation complete ✓"
else
  log "Oh My Zsh already installed ✓"
fi
