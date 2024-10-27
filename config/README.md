# Config

Modules that declare the configurations of NixOS and home-manager.

## NixOS Config Module

### Adding an option

All options declared here MUST be located inside `config.configs`. If you add an option which
contains options, put the module which declares the option that has the same parent option inside
the same directory.

## Home Manager Config Module

Each user has its own `homeManagerModule`. If you add a user in
[`/flake/users.nix`](../flake/users.nix), `home/<username>` will be looked into for modules.

### Adding an option

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
