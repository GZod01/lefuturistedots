#!/bin/bash

# Script to launch a full charpicker
# First it will ask for the category of the special char
# Then it will launch rofimoji with that subset of unicode code point

cd $HOME/dots/charpicker
CHOICE_RES=$(./dump_choices.py | rofi -dmenu)
if [ "$CHOICE_RES" = "" ]; then
    exit
fi

cd /usr/lib/python3.10/site-packages/picker/data
FILES=$(echo $CHOICE_RES | awk -F ' :: ' '{print $1}')
echo $FILES
cat $FILES > /tmp/rofimoji_chars

rofimoji -f /tmp/rofimoji_chars

