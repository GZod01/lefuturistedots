#!/usr/bin/sh

setxkbmap -option caps:none
xmodmap -e 'keycode 9 = grave asciitilde'
xmodmap -e 'keycode 66 = Escape'

echo "remapped I guess"
