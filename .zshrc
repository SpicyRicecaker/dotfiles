# -- PATH UPDATES --

path+="$HOME/.local/bin"

# -- PLUGIN & TOOL INITIALIZATION --

eval "$(/opt/homebrew/bin/brew shellenv)"
source "$HOME/.cargo/env"
eval "$(zoxide init zsh --cmd cd)"
source <(fzf --zsh)

# -- PREFERENCES --

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Simple Prompt (Clean and minimalist)
PROMPT='%~%f '

# -- My Own Modifications --
alias dotgit="git --git-dir='$HOME/dotfiles.git' --work-tree='$HOME'"
