# ~/.zshrc - Primary Zsh configuration file

# Source modular components
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases
[[ -f ~/.zsh_scripts ]] && source ~/.zsh_scripts
[[ -f ~/.zsh_theme ]] && source ~/.zsh_theme

# Shell options
setopt autocd
setopt hist_ignore_dups
setopt share_history

# Enable tab completion
autoload -Uz compinit && compinit

# Ensure ~/repos exists
[[ -d "$HOME/repos" ]] || mkdir -p "$HOME/repos"

# If the shell starts in $HOME (default case), redirect to ~/repos
[[ "$PWD" == "$HOME" ]] && cd "$HOME/repos"
