{ lib
, config
, pkgs
, inputs
, outputs
, nixosConfig
, ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ./dev
    ./apps
    ./misc
    ./cli
    ./desktop
    ./service
    ./gaming
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  # User info
  home = {
    username = "bintang";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.11";
  };

  # Extra packages
  home.packages = [
    inputs.nh.packages."x86_64-linux".default
  ];

  # Overlay
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # Fix DPI
  xresources.properties = {
    "Xft.dpi" = 115;
  };

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;
}
