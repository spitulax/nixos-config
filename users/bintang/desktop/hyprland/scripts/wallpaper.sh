#!/usr/bin/env sh

if [ "$WALLPAPER" != "" ]; then
  swww init
  swww img $WALLPAPER
fi
