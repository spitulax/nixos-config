{ pkgs
, outputs
, inputs
, lib
, config
, ...
}: {
  imports = [
    ./terminal.nix
  ];

  # Packages
  user.shell = "${pkgs.fish}/bin/fish";

  # nix-on-droid stuff
  environment.motd = null;
  time.timeZone = "Asia/Jakarta";

  # Home manager
  home-manager = {
    config = outputs.nixOnDroidHomeConfigurations.default;
    extraSpecialArgs = { inherit inputs outputs; };
    useGlobalPkgs = true;
  };

  # Nix
  nix.registry =
    lib.mapAttrs
      (_: flake: { inherit flake; })
      (lib.filterAttrs
        (_: lib.isType "flake")
        inputs);
  environment.etc =
    lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;
  nix.nixPath =
    map
      (x: "${x}=/etc/nix/path/${x}")
      (builtins.attrNames config.nix.registry);
  nix = {
    settings = {
      inherit (outputs.vars) substituters trusted-public-keys;
    };
    extraOptions = ''
      experimental-features = nix-command flakes repl-flake
    '';
  };

  # State version
  system.stateVersion = "23.11";
}
