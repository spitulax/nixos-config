{ writeShellScriptBin }:
writeShellScriptBin "clean" ''

printf "\033[1;31mPress ENTER to delete system profiles...\n"
printf "\033[0m"
read
sudo nix profile wipe-history --debug --older-than 3d --profile /nix/var/nix/profiles/system

printf "\033[1;31mPress ENTER to delete home-manager profiles...\n"
printf "\033[0m"
read
sudo nix profile wipe-history --debug --older-than 3d --profile $XDG_STATE_HOME/nix/profiles/home-manager

printf "\033[1;31mPress ENTER to run nix store gc...\n"
printf "\033[0m"
read
sudo nix store gc --debug

printf "\033[1;31mRunning nix store optimise...\n"
printf "\033[0m"
sudo nix store optimise

''
