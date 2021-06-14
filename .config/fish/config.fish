# Get rid of default fish greeting
set fish_greeting
# Set prompt to starfish
starship init fish | source

# FZF settings, include hidden files, allow ctrl + t
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --ignore-case'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# Set editor to nvim
set -gx EDITOR nvim
# Set pager to neovim
set -x MANPAGER 'nvim +Man!'
set -x PAGER 'nvim +Man!'

# Git bare repos to manage dotfiles
alias dotgit='git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'