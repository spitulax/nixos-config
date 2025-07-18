#!/usr/bin/env bash

cd `dirname $0`
URLS=$(echo -e "https://github.com/yazi-rs/plugins\n$(cat ./plugins.nix | grep '^  #.*' | cut -c 5-)")
for x in ${URLS[@]}; do
    REV=$(curl -s "$x" | grep -oP '"currentOid":".*?"' | sed -r 's/^".*":"(.*)"$/\1/')
    HASH=$(nix flake prefetch "${x}/archive/master.tar.gz" --json | jq -r '.hash')
    echo -e "\033[1;31m$x\033[0m\n\t$REV\n\t$HASH"
done
