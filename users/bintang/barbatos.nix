{ lib
, config
, pkgs
, inputs
, outputs
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
    ./nix
    ./gaming
    ./nvim
    ./features/keyboard.nix
    ./features/sops.nix
  ];

  # User info
  home = {
    username = "bintang";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.11";
  };

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;

  wayland.windowManager.hyprland = {
    settings = {
      monitor = "eDP-1,preferred,auto,1";
    };
  };
}
