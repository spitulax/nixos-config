#!/usr/bin/env bash

set -euo pipefail

OLDER_THAN=${1:-3d}
if [ "$OLDER_THAN" == "all" ]; then
    FLAGS=""
else
    FLAGS="--older-than $OLDER_THAN"
fi

findResult () {
    fd -t l --hidden --no-ignore --case-sensitive '^result(-.+)?$' $@
}

echo "Run this script after rebooting for the best result."
sudo echo

printf "\033[1;31mPress ENTER to delete \`result\` links...\n"
printf "\033[0m"
read
for i in $(findResult "$HOME" && findResult $(fd -t d '^nh-.*$' /tmp)); do
    echo "Deleting $i"
    sudo unlink $i
done
echo

printf "\033[1;31mPress ENTER to delete home-manager profiles...\n"
printf "\033[0m"
read
nix profile wipe-history --debug $FLAGS --profile $XDG_STATE_HOME/nix/profiles/home-manager
echo

printf "\033[1;31mPress ENTER to delete user profiles...\n"
printf "\033[0m"
read
nix profile wipe-history --debug $FLAGS --profile $XDG_STATE_HOME/nix/profiles/profile
echo

printf "\033[1;31mPress ENTER to delete system profiles...\n"
printf "\033[0m"
read
sudo nix profile wipe-history --debug $FLAGS --profile /nix/var/nix/profiles/system
echo

printf "\033[1;31mPress ENTER to run nix store gc...\n"
printf "\033[0m"
read
sudo nix store gc --debug
echo
