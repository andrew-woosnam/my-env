#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# link-dotfiles.sh
#
# Creates symbolic links for all dotfiles in the dotfiles directory by linking
# each one into the home directory. If a regular file already exists at the
# destination, it is backed up to ~/.dotfile_backups/ with a timestamp before
# being replaced.
#
# This ensures:
# - The home directory uses the repository-managed versions of all dotfiles
# - Any prior configurations are preserved in an organized backup location
# - Environments remain consistent and portable across machines
# -----------------------------------------------------------------------------

if [[ -z "${REPO_DIR:-}" ]]; then
  echo "❌ REPO_DIR is not set. Run this script via setup.sh or define REPO_DIR manually." >&2
  exit 1
fi
LOG_DOMAIN="🔗"
source "$REPO_DIR/scripts/lib/log.sh"

DOTFILES_DIR="$REPO_DIR/dotfiles"
BACKUP_DIR="$HOME/.dotfile_backups"

log "linking dotfiles ..."
mkdir -p "$BACKUP_DIR"

link_file() {
    src="$1"
    dest="$2"
    filename=$(basename "$dest")

    # If the destination exists and is not a symlink, back it up
    if [[ -e "$dest" && ! -L "$dest" ]]; then
        timestamp=$(date +%Y%m%d-%H%M%S)
        backup_path="$BACKUP_DIR/${filename}.${timestamp}.bak"
        mv "$dest" "$backup_path"
        log "backed up $dest → $backup_path"
    fi

    ln -sf "$src" "$dest"
    log "linked $filename → $dest"
}

# Process all hidden files (dotfiles) in dotfiles directory
for src in "$DOTFILES_DIR"/.*; do
    filename=$(basename "$src")

    # Skip special entries
    [[ "$filename" == "." || "$filename" == ".." ]] && continue

    dest="$HOME/$filename"
    link_file "$src" "$dest"
done

log "dotfile linking complete ✓"
