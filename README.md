# 🎛️ my-env

_A lightweight, portable system for setting up a development environment on a new machine._

## Run It

### without git:

```bash
curl -L https://github.com/andrew-woosnam/my-env/archive/refs/heads/main.zip -o my-env.zip \
  && unzip -q my-env.zip \
  && cd my-env-main \
  && ./setup.sh
```

### ... or if git is already installed:

```bash
git clone https://github.com/andrew-woosnam/my-env.git ~/my-env
cd ~/my-env
./setup.sh
```

## How It Works

### 1. Dotfile Setup

- **Symlinks dotfiles** from `dotfiles/` into your home directory (e.g., `.zshrc`, `.zsh_aliases`, etc.)
- **Backs up** existing files in `~` (if not already symlinks) to `~/.dotfile_backups/` with a timestamped filename
- **Modular dotfile layout**:

  - `.zshrc` is the entry point — it sources:

    - `.zsh_aliases`: common shell shortcuts and tool aliases
    - `.zsh_scripts`: shell lifecycle hooks (e.g., command timing)
    - `.zsh_theme`: minimal prompt theme integrated with Oh My Zsh

- **Applies a custom prompt** defined in `.zsh_theme`, using powerline-style segments and Git status
- **Skips non-interactive shells** for relevant files using `[[ -o interactive ]] || return`
- **Ensures `~/repos/` exists** and uses it as the default directory for new shells started in `$HOME`
- All dotfiles are safe to modify locally — rerunning setup won’t clobber them unless symlinks are removed

---

### 2. Shell Configuration

- Ensures **Zsh is installed** and sets it as the default login shell (if not already)
- Uses **Oh My Zsh**, installed via official script (skipping shell auto-switch and default `.zshrc`)
- Custom `.zsh_theme` bypasses standard theme lookup, while still loading OMZ plugins (like `git`)
- `prompt_*` functions define a clean, informative prompt with:

  - Working directory
  - Git branch (with dirty/clean state)
  - Optional AWS context
  - Exit status, root user, and background job markers

- All visual elements support light/dark switching with `SOLARIZED_THEME` env var

---

### 3. Package Installation

- Automatically installs packages using the relevant package managers per OS:

  - **macOS**:

    - Homebrew (`brew`) for core tools
    - `npm` for Node-based tools

  - **Debian-based Linux**:

    - `apt` for system packages

- Each package manager is handled via:

  - A script in `scripts/<platform>/install-<tool>.sh`
  - A plain-text list of packages under `packages/<tool>.txt`
