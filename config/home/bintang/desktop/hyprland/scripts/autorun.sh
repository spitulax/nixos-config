#!/usr/bin/env bash

# Autostart background services
systemctl --user restart keymapper.service
systemctl --user start hyprpaper.service
systemctl --user start hyprpolkitagent.service
systemctl --user start warn-low-battery.service

# Tray icons
systemctl --user disable --now warp-taskbar.service
killall .blueman-applet; blueman-applet &
killall .nm-applet-wrap; nm-applet &

# Waybar
systemctl --user start waybar.service

# Hyprswitch
systemctl --user start hyprswitch.service

# Cliphist
systemctl --user start cliphist.service
