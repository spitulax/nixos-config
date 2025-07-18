{ config
, pkgs
, inputs
, lib
, outputs
, ...
}: {
  config = {
    # Put this flake (as self) and its inputs in the nix registry
    nix.registry =
      lib.mapAttrs
        (_: flake: { inherit flake; })
        (lib.filterAttrs
          (_: lib.isType "flake")
          inputs);

    # Put symlink to nix flake registries to /etc/nix/path
    environment.etc =
      lib.mapAttrs'
        (name: value: {
          name = "nix/path/${name}";
          value.source = value.flake;
        })
        config.nix.registry;

    # Put the flakes in the registry to NIX_PATH so they can be accessed with angular brackets (<>) like channels
    # nix.nixPath just sets the NIX_PATH environment variable but it doesn't work due to a pesky bug https://github.com/NixOS/nix/issues/9574
    nix.nixPath =
      map
        (x: "${x}=/etc/nix/path/${x}")
        (builtins.attrNames config.nix.registry);

    nix = {
      package = lib.mkDefault pkgs.nix;
      settings = {
        inherit (outputs.vars) substituters trusted-public-keys;
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
        trusted-users = [ "root" "@wheel" ];
        nix-path = config.nix.nixPath; # This is a working alternative to nix.nixPath
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than +3";
      };
    };
  };
}
