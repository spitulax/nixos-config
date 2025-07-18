#!/usr/bin/env bash

cd $XDG_CONFIG_HOME/nvim

if [ -r lazy-lock.json ]; then
    mv lazy-lock.json lazy-lock.json.bak
    cp lazy-lock.json.bak lazy-lock.json
    chmod 644 lazy-lock.json
    unlink lazy-lock.json.bak
fi

nvim < /dev/null # run lazy.nvim commands
cp lazy-lock.json ${FLAKE_DIR}/config/home/${1}/nvim/lazy-lock.json
rm lazy-lock.json
echo "You can build your system now to place the lock file back."
