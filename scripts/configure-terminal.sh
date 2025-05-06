#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# configure-terminal.sh
#
# Applies terminal-level configuration such as default shell.
# -----------------------------------------------------------------------------

if [[ -z "${REPO_DIR:-}" ]]; then
  echo "❌ REPO_DIR is not set. Run this script via setup.sh or define REPO_DIR manually." >&2
  exit 1
fi
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
