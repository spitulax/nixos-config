# Modules

## Home Manager Modules

- `keymapper.nix`: Enabling keymapper per user
- `webApps.nix`: Adding browser apps to desktop entry declaratively

## NixOS Modules

- `video-hardware.nix`: Force enabling hardware video acceleration for Intel UHD Graphics
- `keymapper.nix`: Enabling system keymapper service
- `gaming.nix`: Adds steam, gamemode, and other features optimized for gaming
- `laptop.nix`: Laptop specific config, eg. lid action
- `vm.nix`: Setting up virtualization, eg. qemu and waydroid
- `plasma.nix`: KDE Plasma 5

These modules are used inside hosts declaration:
- `common/`: Common config for all hosts
- `desktop/`: Features to enable for desktop hosts
- `server/`: Features to enable for server hosts
- `users/`: The configs for adding users to a host

## Credits

- Both `keymapper.nix` modules are taken from [github:Lillecarl/nixos](https://github.com/Lillecarl/nixos/blob/master/modules/hm/keymapper.nix)
