#!/bin/sh

xrandr --auto && xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1

# to only use the HDM1 output use the command:
# xrandr --output HDMI1 --mode 1920x1080 --output

# old xflux (with french location)
#xflux -l 49.1754262 -g 1.3301737 &

# Start xflux in location russia
xflux -l 54.784568 -g 37.106110 &

# Start notification deamon
dunst &

# old: start laptop monitor (now replaced with batterytator)
#env LAPTOP_MONITOR_PERIOD_IN_MINUTES=2 /home/mbess/dots/laptop_monitor & > /home/mbess/dots/monitor.log

# Start batterytator
/usr/bin/batterytator mbess BAT1 &

i3



