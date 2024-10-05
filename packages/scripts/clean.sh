#!/usr/bin/env bash

set -e

echo "Run this script after rebooting for the best result."
sudo echo

printf "\033[1;31mPress ENTER to delete \`result\` links...\n"
printf "\033[0m"
read
for i in $(find $HOME -name 'result' -type l); do
    echo "Deleting $i"
    unlink $i
done
echo

printf "\033[1;31mPress ENTER to delete home-manager profiles...\n"
printf "\033[0m"
read
nix profile wipe-history --debug --older-than 3d --profile $XDG_STATE_HOME/nix/profiles/home-manager
echo

printf "\033[1;31mPress ENTER to delete user profiles...\n"
printf "\033[0m"
read
nix profile wipe-history --debug --older-than 3d --profile $XDG_STATE_HOME/nix/profiles/profile
echo

printf "\033[1;31mPress ENTER to delete system profiles...\n"
printf "\033[0m"
read
sudo nix profile wipe-history --debug --older-than 3d --profile /nix/var/nix/profiles/system
echo

printf "\033[1;31mPress ENTER to run nix store gc...\n"
printf "\033[0m"
read
sudo nix store gc --debug
echo
