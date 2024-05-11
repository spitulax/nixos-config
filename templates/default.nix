let
  templates = {
    c.path = ./c;
    common.path = ./common;
    rust.path = ./rust;
  };
in
builtins.mapAttrs (k: v: v // { description = ""; }) templates # suppress `nix flake check` error
