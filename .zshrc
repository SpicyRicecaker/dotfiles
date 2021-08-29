# Set history size
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# audocd, globs, error on no match
setopt autocd extendedglob nomatch
# Remove beep on error
unsetopt beep
# Use emacs editing mode
bindkey -e
zstyle :compinstall filename '/home/spicy/.zshrc'
# Enable completion
autoload -Uz compinit
compinit

# FZF settings, include hidden files, allow ctrl + t
# set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --ignore-case'
# set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# Set editor to nvim
export EDITOR=nvim
# Set pager to neovim
# export MANPAGER='nvim +Man!'
# export PAGER='nvim +Man!'

# Git bare repos to manage dotfiles
alias dotgit='git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'

# fish-like syntax highlighting and autosuggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# use sccache to cache stuff
export RUSTC_WRAPPER=sccache

# Use fnm
# eval "$(fnm env)"
# env WAYLAND_DISPLAY= alacritty
# export WAYLAND_DISPLAY=alacritty

# Use starship prompt
eval "$(starship init zsh)"

