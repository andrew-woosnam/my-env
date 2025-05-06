#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# configure-terminal.sh
#
# Applies terminal-level configuration such as default shell.
# -----------------------------------------------------------------------------

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DOMAIN="🖥️"
source "$REPO_DIR/scripts/lib/log.sh"

log "configuring terminal preferences ..."

# Set Zsh as the default shell if not already
if [[ "$SHELL" != "$(which zsh)" ]]; then
  log "changing default shell to Zsh ..."
  chsh -s "$(which zsh)"
  log "default shell changed ✓"
else
  log "Zsh already set as default shell ✓"
fi

log "terminal configuration complete ✓"
