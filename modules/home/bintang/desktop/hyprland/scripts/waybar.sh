#!/usr/bin/env bash

# Start tray icons
killall .blueman-applet; blueman-applet &
killall .nm-applet-wrap; nm-applet &

# Start waybar
killall .waybar-wrapped; waybar &
