# -- PATH UPDATES --

path+="$HOME/.local/bin"
path+="$HOME/go/bin"
path+="~/.local/share/mise/shims"
path+="$HOME/git/kakoune/src"

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
bindkey -v

# -- MODS --
# export EDITOR="nvim"
# export SUDO_EDITOR="nvim"
C="~/dotfiles/.config"
M="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/share/man"

alias dg="git --git-dir='$HOME/dotfiles.git' --work-tree='$HOME'" # dotfiles git
alias ls="eza" # ls
alias n="nvim" # neovim
alias nt="nvim -u $HOME/.config/nvim-backup/init.lua" # edit neovim
alias nc="pushd $C/nvim && n ./lua/plugins.lua && popd" # edit neovim
alias ncc="pushd $C/nvim-backup && n ./lua/plugins.lua && popd" # edit neovim
alias yc="n ~/.yabairc" # edit yabai config
alias sc="n ~/.skhdrc" # edit skhdrc config
alias z="n ~/.zshrc" # edit zsh config
alias sz="source ~/.zshrc"
alias kc="pushd $C/kitty && n ./kitty.conf && popd" # edit kitty config
alias g="cd ~/git/folding-with-yuu && nvim ."
alias s="pushd ~/dotfiles && stow . && popd"
alias mc="n $C/mpv/mpv.conf"
alias i="kitty icat --scale-up"
alias c="cargo run"
alias r="cargo run --release"
alias mx="mise x --"
alias d="cargo doc --open --package"
alias jd="jj describe @- -m"
alias jn="jj new"
T="~/Downloads/trash"
U="/Volumes/USBUSB"
UB="~/Downloads/USBUSBCOPY"
alias uc="pushd $U && n . && popd"
alias us="mv $UB $T && cp -r $U $UB"
alias o="n oil-ssh://arch/"
alias tc="pushd $HOME/.config/tmux && n tmux.conf && popd"
alias ts="tmux source $HOME/.config/tmux/tmux.conf"
alias t="tmux attach"

# bun completions
[ -s "/Users/oliver/.bun/_bun" ] && source "/Users/oliver/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# export PAGER="nvim +Man! -c 'setlocal scrolloff=999' -c 'norm M'"
# export PAGER="nvim +Man!"
# export MAN_KEEP_FORMATTING=1

export PATH=$PATH:/Users/oliver/.spicetify

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/oliver/.juliaup/bin' $path)
export PATH
# Tab completion for juliaup and julia channel selection
[ -f "/Users/oliver/.julia/juliaup/completions/zsh.zsh" ] && source "/Users/oliver/.julia/juliaup/completions/zsh.zsh"

# <<< juliaup initialize <<<
