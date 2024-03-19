#!/usr/bin/env sh

pkill swww-daemon
swww init

if [ "$WALLPAPER" != "" ]; then
  swww img $WALLPAPER
fi
