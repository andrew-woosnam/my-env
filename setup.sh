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
# This script assumes the repository has been cloned to $HOME/my-env.
# -----------------------------------------------------------------------------

REPO_DIR="$HOME/my-env"

echo "🎛️ Setting up environment from $REPO_DIR ..."

"$REPO_DIR/scripts/link-dotfiles.sh"
"$REPO_DIR/scripts/install-packages.sh"
"$REPO_DIR/scripts/configure-terminal.sh" 

echo "🎛️ Environment setup complete ✓"
