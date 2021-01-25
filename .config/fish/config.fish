# Get rid of default fish greeting
set fish_greeting
# Set prompt to starfish
starship init fish | source
# Set editor to nvim
set -gx EDITOR nvim

# FZF settings, include hidden files, allow ctrl + t
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --ignore-case'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# Set pager to neovim
set -x PAGER nvim
set -x MANPAGER nvim

# Git bare repos to manage dotfiles
alias dotgit='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Deno stuff
set -x DENO_INSTALL /home/spicy/.deno

# Path
set PATH /home/spicy/.opt/texlab-x86_64-linux $DENO_INSTALL/bin /home/spicy/.opt/dart-sass $PATH

# Function to swap files
function swap
  mv $argv[2] tmp_file_for_swap
  mv $argv[1] $argv[2]
  mv tmp_file_for_swap $argv[1]
end
