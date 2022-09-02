#!/bin/bash
# gets the currently focused window's id
current_focused_window_id=$(xprop -root -f _NET_ACTIVE_WINDOW 0x " \$0\\n" _NET_ACTIVE_WINDOW | awk "{print \$2}")

# get the tile for the current window
window_title=$(xprop -id $current_focused_window_id | sed -ne 's/WM_NAME(STRING) = "\(.*\)"/\1/p')

# in my set up the title looks like "user@machine:path", this line uses sed to graph the path only after :
preferred_cwd=$(echo $window_title | sed -e 's/.*://')

echo $preferred_cwd

