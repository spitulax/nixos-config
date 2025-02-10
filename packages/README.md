# Packages

Some packages that are available in this flake and overlaid to pkgs within `custom` attrset.

Build using `nix build .#<name>`

## List

- `scripts`: Symlink join of many simple bash scripts to make my life easier

> Contains multiple scripts:
>
> - `brightness`: Control monitor brightness
> - `clean`: Wrapper to `nix store gc` that also deletes old profiles
> - `hyprmon`: Quickly configure monitors for Hyprland
> - `lazyup`: A hacky (stupid) way to update/install lazy.nvim plugins
> - `notes`: Open $NOTES_DIR in Neovim
> - `remind`: Wrap a command to send notification when completed
> - `reminder`: Simple (scuffed) reminder with notify-send
> - `screenshot`: Wrapper script to grim (wayland screenshot)
> - `timeinfo`: Print system uptime or system installation age
> - `tmuxs`: Tmux that search for .tmux socket
> - `upfind`: Find files up the directory tree
> - `volume`: Control volume
> - `wallpaper`: Control wallpaper with hyprpaper
> - `winekill`: Kill all running Wine process
