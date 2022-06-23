#!/bin/bash

# launch a calculator
# using https://github.com/svenstaro/rofi-calc

rofi -show calc -modi calc -no-show-match -no-sort -calc-command "echo -n '{result}' | xclip -selection c"

