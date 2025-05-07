#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# macos-packages.sh
#
# Delegates package installation on macOS to each supported package manager.
# Each package manager has its own script under scripts/macos/install-<tool>.sh
# and a matching package list under packages/<tool>.txt.
# -----------------------------------------------------------------------------

if [[ -z "${REPO_DIR:-}" ]]; then
  echo "❌ REPO_DIR is not set. Run this script via setup.sh or define REPO_DIR manually." >&2
  exit 1
fi
LOG_DOMAIN="📦 🍎"
source "$REPO_DIR/scripts/lib/log.sh"

MANAGER_SCRIPTS_DIR="$REPO_DIR/scripts/macos"

log "installing packages via supported package managers ..."

package_managers=(
  brew
  npm
)

for manager in "${package_managers[@]}"; do
  script="$MANAGER_SCRIPTS_DIR/install-$manager.sh"

  if [[ -x "$script" ]]; then
    "$script"
  else
    log "⚠️ Skipping $manager: script not found or not executable at $script"
  fi
done

log "all package manager installs complete ✓"
