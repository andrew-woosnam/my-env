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
# This script assumes it is being run from the root of the repository,
# located at $REPO_DIR/setup.sh
# -----------------------------------------------------------------------------

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$REPO_DIR/scripts/lib/log.sh"

log "Setting up environment from $REPO_DIR ..."

# Ensure expected subdirectories exist (safe to run even if already present)
mkdir -p "$REPO_DIR/scripts/macos"
mkdir -p "$REPO_DIR/scripts/linux"
mkdir -p "$REPO_DIR/packages"
mkdir -p "$REPO_DIR/dotfiles"

# Run setup steps
"$REPO_DIR/scripts/link-dotfiles.sh"
"$REPO_DIR/scripts/install-packages.sh"
"$REPO_DIR/scripts/configure-terminal.sh"

log "Environment setup complete ✓"
