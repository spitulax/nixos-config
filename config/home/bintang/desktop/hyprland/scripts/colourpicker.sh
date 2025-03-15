#!/usr/bin/env bash

set -eu pipefail

COLOUR=$(hyprpicker -a -f hex)
[ -n "$COLOUR" ] && notify-send -a popup -t 5000 "Colour copied" "󰏘  $COLOUR" &
