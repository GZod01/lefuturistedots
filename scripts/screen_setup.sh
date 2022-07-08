#!/bin/bash

# TODO: fix to have POSIX shell compliant script

laptop() {
  xrandr --output DP1 --off --output HDMI1 --off --output eDP1 --mode 1366x768
  ~/dots/scripts/refresh_wallpapers.sh
}

home_hdmi_edp() {
  xrandr --output DP1 --off --output eDP1 ---mode 1366x768 -output HDMI1 --mode 1920x1080 --left-of eDP1 

  #~/dots/scripts/i3_migrate_output.py HDMI1
  ~/dots/scripts/refresh_wallpapers.sh
}

home_vga_hdmi_edp() {
  xrandr --output DP1 --mode 1366x768 --output HDMI1 --mode 1920x1080 --left-of eDP1
  ~/dots/scripts/refresh_wallpapers.sh
}

home_vga_hdmi() {
  echo -n ""
}

home_vga() {
  xrandr --output DP1 --mode 1366x768 --output HDMI1 --off --output eDP1 --off
  ~/dots/scripts/refresh_wallpapers.sh
}

home_hdmi() {
  xrandr --output DP1 --off --output HDMI1 --mode 1920x1080 --output eDP1 --off
  ~/dots/scripts/refresh_wallpapers.sh
}

auto() {
  xrandr --auto
  ~/dots/scripts/refresh_wallpapers.sh
}

if [[ $1 =~ ^(auto|laptop|home_hdmi|home_vga|home_hdmi_edp|home_vga_hdmi_edp|home_vga_only)$ ]]; then
  "$@"
else
  echo "Invalid subcommand $1" >&2
  echo "Usage: ./screen_setup.sh auto|laptop|home_hdmi|home_vga|home_hdmi_edp|home_vga_hdmi_edp|home_vga_only"
  exit 1
fi
