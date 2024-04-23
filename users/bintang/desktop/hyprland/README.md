# Hyprland Configuration

NOTE:
- Monitor configuration is defined for each hosts in `/users/<user>/<host>.nix`.

## Mako (`./mako/`)

[Mako](https://github.com/emersion/mako) is a lightweight Wayland notification daemon.

## Rofi (`./rofi/`)

[Rofi-Wayland](https://github.com/lbonn/rofi) is a window switcher, run dialog with wayland support

## Scripts (`./scripts/`)

- `autorun.sh`: executed on launch
- `run.sh`: launcher for common apps

## Waybar (`./waybar/`)

[Waybar](https://github.com/alexays/waybar) configuration.

## TODO

- [ ] Mako on-notify sound is sometimes too low
- [ ] Add [`hyprspace`](https://github.com/KZDKM/Hyprspace)
> Also add a module to waybar that displays window count and toggle hyprspace when clicked
