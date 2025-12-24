# -- PATH UPDATES --

path+="$HOME/.local/bin"

# -- PLUGIN & TOOL INITIALIZATION --

eval "$(/opt/homebrew/bin/brew shellenv)"
source "$HOME/.cargo/env"
eval "$(zoxide init zsh --cmd cd)"
# source <(fzf --zsh)
# eval "$(jenv init -)"

# -- PREFERENCES --

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Simple Prompt (Clean and minimalist)
PROMPT='%~%f '

# -- MODS --
EDITOR="nvim"
C="~/.config"
alias dg="git --git-dir='$HOME/dotfiles.git' --work-tree='$HOME'" # dotfiles git
alias ls="eza" # ls
alias n="nvim" # neovim
alias nc="pushd $C/nvim && n ./lua/plugins.lua && popd" # edit neovim
alias yc="n ~/.yabairc" # edit yabai config
alias sc="n ~/.skhdrc" # edit skhdrc config
alias z="n ~/.zshrc" # edit zsh config
alias kc="pushd $C/kitty && n ./kitty.conf && popd" # edit kitty config
alias g="cd ~/git/folding-with-yuu && nvim ."

# bun completions
[ -s "/Users/oliver/.bun/_bun" ] && source "/Users/oliver/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
