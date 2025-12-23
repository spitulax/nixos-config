#!/usr/bin/env bash

set -euo pipefail

swaymsg -t get_tree | \
    jq -r 'recurse(.nodes[], .floating_nodes[]) | select((.type == "con" or .type == "floating_con") and (.nodes == [] and .floating_nodes == [])) | "\(.id)\t\(.name)"' | \
    tofi --prompt-text WINDOWS --config ~/.config/tofi/vertical | \
    xargs -d '\t' sh -c 'swaymsg [con_id=$0] focus'
