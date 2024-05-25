# Modules

## Home Manager Modules

These modules are optional features that can be manually enabled per host.
Enable it by adding `outputs.homeManagerModules.<name>` to `imports` in user config.

- `keymapper`: Enable keymapper user config and service
- `webApps`: Add browser apps to desktop entry declaratively

## NixOS Modules

These modules are used inside hosts declaration:
- `common/`: Common config for all hosts
- `desktop/`: Features to enable for desktop hosts
- `features/`: See [here](#nixos-feature-module)
- `laptop/`: Laptop specific config, eg. lid action
- `server/`: Features to enable for server hosts
- `users/`: The configs for adding users to a host

### NixOS Feature Module

These modules are optional features that can be manually enabled per host.
Enable it by adding `outputs.nixosModules.features.<name>` to `imports` in `hosts/<host>/default.nix`.

- `avahi`: Avahi service
- `gaming`: Add steam, gamemode, and other features optimized for gaming
- `keymapper`: System keymapperd service
- `plasma`: KDE Plasma 5
- `video-hardware`: Force enabling hardware video acceleration for Intel UHD Graphics
- `vm`: Virtualization, eg. qemu and waydroid
- `warp`: Cloudflare warp service
- `zram`: Zram swap
