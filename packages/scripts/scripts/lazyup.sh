#!/usr/bin/env bash

cd $XDG_CONFIG_HOME/nvim

if [ -r lazy-lock.json ]; then
    mv lazy-lock.json lazy-lock.json.bak
    cp lazy-lock.json.bak lazy-lock.json
    chmod 644 lazy-lock.json
    unlink lazy-lock.json.bak
fi

TEMPFILE=$(mktemp)
echo 'Run `:Lazy update` or any other lazy.nvim commands.' > "$TEMPFILE"
chmod -w "$TEMPFILE"
nvim "$TEMPFILE"
cp lazy-lock.json ${FLAKE_DIR}/config/home/${1}/nvim/lazy-lock.json
rm lazy-lock.json
echo "You can build your system now to place the lock file back."
