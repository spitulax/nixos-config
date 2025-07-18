# Config

Modules that declare the configurations of NixOS and Home Manager. The config module is just like
any regular NixOS or Home Manager module.

## NixOS Config Module

This module is to be used in [`/hosts/`](../hosts). Use it by importing `outputs.nixosConfigModule`.
Importing `outputs.nixosConfigModule` makes the config easily customisable with pre-defined options.
If something needs to be adjusted for a single host put the module inside the `hosts/<hostname>`
directory and adjust the needed options like usual.

## Home Manager Config Module

This module is to be used in [`/users/`](../users). Use it by importing
`users.<user>.homeManagerModule`. Each user has their own `homeManagerModule`. If you add a user in
[`/flake/users.nix`](../flake/users.nix), `home/<username>` will be looked into for modules. Just
like [NixOS config module](#nixos-config-module), user config module is just like any regular
home-manager module. But the `users` attribute set provides a Home Manager module to simplify
customisation just like what `nixosConfigModule` does. To use it, import
`users.<username>.homeManagerModule`.

## Special Arguments

Alongside default arguments passed by NixOS and Home Manager, other arguments are passed to modules.
These extra arguments are defined in [`/flake.nix`](../flake.nix) as `specialArgs`.

## Adding an option

All options declared here **MUST** be located inside `config.configs`. If you add an option which
contains options, put the module which declares the option that has the same parent option inside
the same directory.

### Template

```nix
{ config
, lib
, ...
}:
let
  cfg = config.configs.foobar;
in
{
  options.configs.foobar.enable = lib.mkEnableOption "foobar";

  config = lib.mkIf cfg.enable {
    # ...
  };
}
```
