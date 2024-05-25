{ pkgs
, outputs
, inputs
, lib
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
    config = ../../users/bintang/hosts/dantalion;
    extraSpecialArgs = { inherit inputs outputs; };
    useGlobalPkgs = true;
  };

  # Nix
  nix = {
    registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
    settings = {
      inherit (outputs.vars) substituters trusted-public-keys;
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # State version
  system.stateVersion = "23.11";
}
