#!/bin/bash

export DISPLAY=:0

mkdir -p $HOME/.logs/i3_overlay

echo "started i3_overlay"

LOG_FILE=$HOME/.logs/i3_overlay/log.txt

# python3 $HOME/dots/scripts/i3_overlay.py 2>&1 | tee 
python3 $HOME/dots/scripts/i3_overlay.py

# RAGE:
# logging didnt work all GNu coreutils are shit especially shell redirection and tee 


