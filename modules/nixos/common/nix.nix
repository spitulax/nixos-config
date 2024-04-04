{ pkgs
, config
, inputs
, lib
, outputs
, ...
}: {
  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc =
    lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      inherit (outputs) substituters trusted-public-keys;
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
      trusted-users = [ "root" "@wheel" ];
      nix-path = "nixpkgs=/etc/nix/path/nixpkgs"; # https://github.com/NixOS/nix/issues/9574
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +3";
    };
  };
  nixpkgs.pkgs = outputs.pkgs.nixos;
}
