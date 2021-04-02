#!/bin/sh

# Import xres options
# - Currently entirely for the purposes of DPI scaling
# - See https://wiki.archlinux.org/index.php/HiDPI#X_Resources
xrdb -merge ~/.Xresources

# Set escape as an additional caps
# - See https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration#Using_setxkbmap
setxkbmap -option caps:escape
# Reduce time that it takes for a pressed key to start repeating, and increases amount of repeats per second
# - See https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration#Using_xset
xset r rate 300 50

# Start input language server
fcitx5 &

# - Purpose: Start a night light so your eyes don't become Spongebob bloodshot eyes at night
# 1. Start redshift
#   - See https://wiki.archlinux.org/index.php/redshift#Configuration
#   - Make sure to manually add location to the `redshift.conf` file!
# 
#     ~/.config/redshift/redshift.conf
#     [redshift]
#     location-provider=manual
#     
#     [manual]
#     lat=?
#     lon=?
redshift &

# - Purpose: Make VSCode settings sync auto-login work on arch linux
# - References the official VSCode docs: https://code.visualstudio.com/docs/editor/settings-sync#_linux
# 1. Start the gnome-keyring daemon on login
#   - (refer to https://wiki.archlinux.org/index.php/GNOME/Keyring#xinitrc_method)
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
# 2. Set the DISPLAY and XAUTHORITY environment variables explicitly, they affect keyring management(I don't get it either)
#   - See Sarah's comment @ https://github.com/microsoft/vscode/issues/92972#issuecomment-602919353
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# Start our window manager!
exec awesome
