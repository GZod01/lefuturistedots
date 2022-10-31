#!/bin/sh

# Setup display
xrandr --auto && xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1

# to only use the HDM1 output use the command:
# xrandr --output HDMI1 --mode 1920x1080 --output

# setup remap
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

picom &

# old xflux (with french location)
#xflux -l 49.1754262 -g 1.3301737 &

# Start xflux in location russia
xflux -l 54.784568 -g 37.106110 &

# Start notification deamon
dunst &

# Start network manager applet
# nm-applet

# Start xbanish to hide mouse cursor when typing
xbanish &

# Start kdeconnect! dangerous
# /usr/lib/kdeconnectd &

# Prevent paste mouseblock
# I had to install it without using pacman
/mnt/extra/data/_content/apps/XMousePasteBlock/xmousepasteblock &

# Start greenclip
greenclip daemon &

# Start batterytator
/usr/bin/batterytator mbess BAT1 &

# Start joplin
/opt/appimages/Joplin.AppImage --no-sandbox %U &

# old: start laptop monitor (now replaced with batterytator)
#env LAPTOP_MONITOR_PERIOD_IN_MINUTES=2 /home/mbess/dots/laptop_monitor & > /home/mbess/dots/monitor.log

# setup keychain
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# Start blueman
blueman-applet &

# Start network manager applet
nm-applet &

sh $HOME/dots/scripts/refresh_wallpapers.sh &

i3

