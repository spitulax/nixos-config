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
  environment.packages = with pkgs; [
    git
    neovim
    wget
    curl
    fish
    rsync
    openssh
  ];
  user.shell = "${pkgs.fish}/bin/fish";

  # nix-on-droid stuff
  environment.motd = null;
  time.timeZone = "Asia/Jakarta";

  # Home manager
  home-manager = {
    config = ../../users/bintang/dantalion.nix;
    extraSpecialArgs = { inherit inputs outputs; };
    useGlobalPkgs = true;
  };

  # Nix
  nix = {
    registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    substituters = [
      "https://cache.nixos.org"
      "https://nix-on-droid.cachix.org"
    ];
    trustedPublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU="
    ];
  };

  # State version
  system.stateVersion = "23.11";
}
