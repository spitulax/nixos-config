# Users

- `bintang`: Me

## Config

The modules are used by `myLib.homeManagerConfig`. You may also want to import
`users.<username>.homeManagerModule` to utilise the
[Home Manager config module](../config/README.md#home-manager-config-module). See
[here](./bintang_barbatos/default.nix) for an example of Home Manager config module.

## Special Arguments

See [here](../config/README.md#special-arguments).

## Structure

Each subdirectory contains a configuration for a user in a host machine. The name format is
`<username>_<hostname>` because I don't want to nest another directory just to kind of structure
this directory hierarchically.
