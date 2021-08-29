# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/spicy/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export EDITOR=nvim
alias dotgit='git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'
eval "$(starship init zsh)"
