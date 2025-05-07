#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# setup.sh
#
# Entrypoint for configuring a development environment.
# -----------------------------------------------------------------------------

# Error handling
trap 'echo "❌ ERROR: Command failed at line $LINENO. Check the output above for details."' ERR

SCRIPT_PATH="${BASH_SOURCE[0]}"
REPO_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
export REPO_DIR

source "$REPO_DIR/scripts/lib/log.sh"
log "Setting up environment from $REPO_DIR ..."

# Create required directories and empty package files if needed
mkdir -p "$REPO_DIR"/{scripts/macos,scripts/linux,packages,dotfiles}
touch "$REPO_DIR/packages/"{brew,npm,pnpm,apt}.txt

# Check for critical files in the expected repo structure
required_paths=(
  "$REPO_DIR/scripts/link-dotfiles.sh"
  "$REPO_DIR/scripts/install-packages.sh"
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

# Make all scripts executable
find "$REPO_DIR/scripts" -name "*.sh" -type f -exec chmod +x {} \;

# Run setup steps
"$REPO_DIR/scripts/link-dotfiles.sh"
"$REPO_DIR/scripts/install-packages.sh"

log "Environment setup complete ✓"