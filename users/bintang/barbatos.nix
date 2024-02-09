{ lib
, config
, pkgs
, inputs
, outputs
, ...
}: {
  imports = [
    ./dev
    ./apps
    ./misc
    ./cli
    ./desktop
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  # User info
  home = {
    username = "bintang";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.11";
  };

  # Overlay
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # # Fix DPI
  # xresources.properties = {
  #   "Xft.dpi" = 105;
  # };

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;
}
