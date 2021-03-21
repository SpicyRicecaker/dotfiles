#!/bin/sh

# Import xres options, has DPI scaling
xrdb -merge ~/.Xresources

# Set escape as an additional caps
setxkbmap -option caps:escape
# Reduce time for holding
xset r rate 300 50

# Start input language server
fcitx5 &

# Start keyring on login
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# No idea why the fk DISPLAY and XAUTHORITY environment variables affect keyring management but they do so?
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

exec awesome
