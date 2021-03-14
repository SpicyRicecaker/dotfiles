#!/bin/sh

# Import xres options, has DPI scaling
xrdb -merge ~/.Xresources
# Set escape as an additional caps
setxkbmap -option caps:escape
exec awesome
