#!/usr/bin/env bash

# Tray icons
killall .blueman-applet; blueman-applet &
killall .nm-applet-wrap; nm-applet &

# Waybar
systemctl --user start waybar.service

# Hyprswitch
systemctl --user start hyprswitch.service

# Hyprpaper
systemctl --user start hyprpaper.service

# Autostart background services
# BUG: keymapper has to be double started
systemctl --user start keymapper.service
systemctl --user restart keymapper.service
systemctl --user start hyprpolkitagent.service
systemctl --user start warn-low-battery.service
systemctl --user start cliphist.service

