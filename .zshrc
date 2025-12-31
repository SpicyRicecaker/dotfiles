# -- PATH UPDATES --

path+="$HOME/.local/bin"
path+="$HOME/go/bin"

# -- PLUGIN & TOOL INITIALIZATION --

eval "$(/opt/homebrew/bin/brew shellenv)"
source "$HOME/.cargo/env"
eval "$(zoxide init zsh --cmd cd)"
source <(fzf --zsh)
eval "$(~/.local/bin/mise activate zsh)"
# eval "$(jenv init -)"

# -- PREFERENCES --

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Simple Prompt (Clean and minimalist)
PROMPT='%~%f '

# -- MODS --
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
C="~/dotfiles/.config"
alias dg="git --git-dir='$HOME/dotfiles.git' --work-tree='$HOME'" # dotfiles git
alias ls="eza" # ls
alias n="nvim" # neovim
alias nc="pushd $C/nvim && n ./lua/plugins.lua && popd" # edit neovim
alias yc="n ~/.yabairc" # edit yabai config
alias sc="n ~/.skhdrc" # edit skhdrc config
alias z="n ~/.zshrc" # edit zsh config
alias sz="source ~/.zshrc"
alias kc="pushd $C/kitty && n ./kitty.conf && popd" # edit kitty config
alias g="cd ~/git/folding-with-yuu && nvim ."
alias s="pushd ~/dotfiles && stow . && popd"

# bun completions
[ -s "/Users/oliver/.bun/_bun" ] && source "/Users/oliver/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# export PAGER="nvim +Man! -c 'setlocal scrolloff=999' -c 'norm M'"
export PAGER="nvim +Man!"
export MAN_KEEP_FORMATTING=1
