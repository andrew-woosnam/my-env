#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# configure-terminal.sh
#
# Stub for terminal configuration steps. This script can be extended to apply
# terminal emulator preferences (e.g., import iTerm2 profiles, set default shell).
# -----------------------------------------------------------------------------

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DOMAIN="🖥️"
source "$REPO_DIR/scripts/lib/log.sh"

log "configuring terminal ..."

# TODO

log "terminal configuration complete ✓"
