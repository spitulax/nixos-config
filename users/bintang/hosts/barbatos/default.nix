{ config
, inputs
, ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ../../dev
    ../../apps
    ../../misc
    ../../cli
    ../../desktop
    ../../service
    ../../nix
    ../../gaming
    ../../nvim
    ../../features/keyboard.nix
    ../../features/sops.nix

    ./hyprland.nix
  ];

  # User info
  home = {
    username = "bintang";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.11";
  };

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;
}
