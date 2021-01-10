set fish_greeting
starship init fish | source
set -gx EDITOR nvim
set PATH /home/spicy/.opt/texlab-x86_64-linux $PATH

set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --ignore-case'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x PAGER nvim

alias dotgit='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
