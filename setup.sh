#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# setup.sh
#
# Entrypoint for configuring a development environment.
# Performs the following actions:
# - Symlinks version-controlled dotfiles from this repository into the home directory
# - Installs standard development tools using the system's package manager
# - Configures terminal preferences / other environment settings
#
# This script can be run from anywhere and resolves the repository directory
# based on the location of this file.
# -----------------------------------------------------------------------------

SCRIPT_PATH="${BASH_SOURCE[0]}"
REPO_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
export REPO_DIR

source "$REPO_DIR/scripts/lib/log.sh"
log "Setting up environment from $REPO_DIR ..."

# Check for critical files in the expected repo structure
required_paths=(
  "$REPO_DIR/scripts/link-dotfiles.sh"
  "$REPO_DIR/scripts/install-packages.sh"
  "$REPO_DIR/scripts/configure-terminal.sh"
  "$REPO_DIR/scripts/lib/log.sh"
)

for path in "${required_paths[@]}"; do
  if [[ ! -f "$path" ]]; then
    echo "❌ Required file missing: $path"
    echo
    echo "This script must be part of a valid 'my-env' repo directory structure."
    echo "Expected to find: scripts/, dotfiles/, packages/, etc."
    exit 1
  fi
done

# Ensure expected subdirectories exist (safe to run even if already present)
mkdir -p "$REPO_DIR"/{scripts/macos,scripts/linux,packages,dotfiles}

# Run setup steps
"$REPO_DIR/scripts/link-dotfiles.sh"
"$REPO_DIR/scripts/install-packages.sh"
"$REPO_DIR/scripts/configure-terminal.sh"

log "Environment setup complete ✓"
