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
set -x MANPAGER 'nvim +Man!'
set -x PAGER 'nvim +Man!'
# Set default editor to neovim
set -x EDITOR nvim

# Git bare repos to manage dotfiles
alias dotgit='git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'

# Deno stuff
set -x DENO_INSTALL /home/spicy/.deno

# Set GTK scaling to 2
# set -x GDK_SCALE 2

# Set parallel compilation
set -x MAKEFLAGS '-j$(nproc)'

# Set default platform theme
# set -x QT_QPA_PLATFORMTHEME qt5ct
set -x QT_XCB_TABLET_LEGACY_COORDINATES ""

# Path
set PATH $HOME/.opt/texlab-x86_64-linux $DENO_INSTALL/bin $HOME/.opt/dart-sass $HOME/.npm/bin $HOME/.cargo/bin $PATH

# On login, open the xorg server!
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end
