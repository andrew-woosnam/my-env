# 🎛️ my-env

A lightweight, portable system for setting up a development environment on a new machine.  
This repository manages shell configurations, dotfiles, and common tools to provide a consistent and reproducible working environment.

## Features

- Symlinks version-controlled dotfiles into the home directory
- Installs standard development packages.
- Modular structure for adding additional tools or customizations
- Designed to be safe, idempotent, and easy to maintain

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/my-env.git ~/my-env
cd ~/my-env
```

### 2. Run the setup script

```bash
./setup.sh
```

This will:

- Symlink dotfiles from `dotfiles/` into the home directory
- Install development packages via `brew` (macOS) or `apt` (Debian/Ubuntu)

## Customization

- **Shell configuration**: Add or modify files under `dotfiles/` (e.g. `.zshrc`, `.aliases`)
- **Tools**: Extend `scripts/install-packages.sh` to include additional software
- **System configs**: Add platform-specific settings under `configs/` and source them from scripts as needed

## Notes

- Existing files in `~` that are not symlinks will be left untouched
- The system is safe to re-run; symlinks will be updated if needed
- Assumes the repository lives at `~/my-env`; modify `REPO_DIR` in scripts if placed elsewhere
