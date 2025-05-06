#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# install-brew.sh
#
# Ensures Homebrew is installed and installs packages defined in packages/brew.txt.
# -----------------------------------------------------------------------------

echo "🎛️ 📦 [brew] installing packages ..."

REPO_DIR="$HOME/my-env"
PACKAGE_LIST="$REPO_DIR/packages/brew.txt"

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "🎛️ 📦 Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "🎛️ 📦 Homebrew already installed ✓"
fi

# Install packages
if [[ -f "$PACKAGE_LIST" ]]; then
  while read -r pkg; do
    [[ -z "$pkg" || "$pkg" == \#* ]] && continue  # skip empty lines and comments
    echo "🎛️ 📦 brew install $pkg"
    brew install "$pkg"
  done < "$PACKAGE_LIST"
else
  echo "🎛️ 📦 ⚠️ Package list not found at $PACKAGE_LIST"
fi

echo "🎛️ 📦 [brew] package installation complete ✓"
