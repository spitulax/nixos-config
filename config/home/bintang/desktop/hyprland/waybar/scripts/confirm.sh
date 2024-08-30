#!/usr/bin/env bash

CHOICE=$(echo -e "Yes\nNo" | rofi -dmenu -p "$1")
if [[ $CHOICE == "Yes" ]]; then
  $2 &
fi
