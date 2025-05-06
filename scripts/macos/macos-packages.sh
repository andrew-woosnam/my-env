#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# macos-packages.sh
#
# Delegates package installation on macOS to each supported package manager.
# Each package manager has its own script under scripts/macos/install-<tool>.sh
# and a matching package list under packages/<tool>.txt.
# -----------------------------------------------------------------------------

echo "🎛️ 📦 [macos] installing packages via supported package managers ..."

REPO_DIR="$HOME/my-env"
MANAGER_SCRIPTS_DIR="$REPO_DIR/scripts/macos"

# Define the supported package managers (must match script and package list)
package_managers=(
  brew
  npm
  pnpm
)

for manager in "${package_managers[@]}"; do
  script="$MANAGER_SCRIPTS_DIR/install-$manager.sh"

  if [[ -x "$script" ]]; then
    "$script"
  else
    echo "🎛️ 📦 ⚠️ Skipping $manager: script not found or not executable at $script"
  fi
done

echo "🎛️ 📦 [macos] all package manager installs complete ✓"
