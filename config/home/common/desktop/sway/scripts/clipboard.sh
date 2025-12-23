#!/usr/bin/env bash

set -euo pipefail

cliphist -preview-width 512 list | \
    tofi --prompt-text CLIPBOARD --config ~/.config/tofi/vertical | \
    cliphist decode | \
    wl-copy
