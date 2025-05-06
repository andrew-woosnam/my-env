#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# install-npm.sh
#
# Ensures Node.js and npm are installed (via Homebrew),
# then installs global npm packages defined in packages/npm.txt.
# -----------------------------------------------------------------------------

echo "🎛️ 📦 [npm] installing global npm packages ..."

REPO_DIR="$HOME/my-env"
PACKAGE_LIST="$REPO_DIR/packages/npm.txt"

# Ensure Node.js and npm are installed
if ! command -v npm &>/dev/null; then
  echo "🎛️ 📦 npm not found. Installing via Homebrew..."
  brew install node
else
  echo "🎛️ 📦 npm already installed ✓"
fi

# Install packages
if [[ -f "$PACKAGE_LIST" ]]; then
  while read -r pkg; do
    [[ -z "$pkg" || "$pkg" == \#* ]] && continue
    echo "🎛️ 📦 npm install -g $pkg"
    npm install -g "$pkg" || echo "🎛️ 📦 ⚠️ failed to npm install $pkg"
  done < "$PACKAGE_LIST"
else
  echo "🎛️ 📦 ⚠️ Package list not found at $PACKAGE_LIST"
fi

echo "🎛️ 📦 [npm] package installation complete ✓"
