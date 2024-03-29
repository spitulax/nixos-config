{ lib
, config
, pkgs
, inputs
, outputs
, ...
}: {
  imports = [
    ./dev
    ./misc
    ./cli
    ./nvim
  ];

  # User info
  home = {
    sessionVariables = {
      ROOT = "/data/data/com.termux.nix/files/";
    };
    username = "localhost";
    homeDirectory = "${config.home.sessionVariables.ROOT}/home";
    stateVersion = "23.11";
  };

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;
}
