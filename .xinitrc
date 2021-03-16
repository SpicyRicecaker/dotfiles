#!/bin/sh

# Import xres options, has DPI scaling
xrdb -merge ~/.Xresources

# Set escape as an additional caps
setxkbmap -option caps:escape
# Reduce time for holding
xset r rate 300 50

# Start input language server
fcitx5 &

exec awesome
