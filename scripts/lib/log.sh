#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# log.sh
#
# Provides a reusable log() function.
# Always prefixes with 🎛️ to indicate "my-env" project.
# Allows scripts to define LOG_DOMAIN (e.g. "📦", "🔗🧪") for additional context.
#
# Usage:
#   LOG_DOMAIN="📦"        # optional
#   source "$REPO_DIR/scripts/lib/log.sh"
#   log "Installing packages..."
# -----------------------------------------------------------------------------

log() {
    echo "🎛️ ${LOG_DOMAIN:-} $*"
}
