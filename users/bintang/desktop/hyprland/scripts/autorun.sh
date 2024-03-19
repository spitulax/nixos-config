#!/usr/bin/env sh

# Display wallpaper
./wallpaper.sh

# Start waybar
pkill waybar
waybar &
sleep 2 # wait waybar to load

# Autostart apps
zapzap &
blueman-applet &
nm-applet &
