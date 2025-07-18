# Flake

Stuff to be imported by [`flake.nix`](../flake.nix) (probably needs a better name).

## [`configs.nix`](./configs.nix)

Declaration of configs. Use `nixosConfig` and `homeManagerConfig` from `myLib` to define NixOS
configs and home-manager configs respectively.

NixOS configs' attribute names are the hostnames. The config modules are located in
[`/hosts/`](../hosts).

Home Manager configs' attribute names are "\<username\>@\<hostname\>". The config modules are
located in [`/users/`](../users) one for each combination of users and host systems.

## [`users.nix`](./users.nix)

Declaration of users. Use `mkUser` from `myLib` to define users.

## [`vars.nix`](./flake/vars.nix)

Variables that are shared with configs, modules, etc. so they are declared in flake to make them
globally accessible.
