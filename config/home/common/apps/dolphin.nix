{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.configs.apps.dolphin;
in
{
  options.configs.apps.dolphin = {
    enable = lib.mkEnableOption "Dolphin file manager";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs.kde; [
      dolphin
      ffmpegthumbs
      kio-extras
    ];

    # https://discourse.nixos.org/t/dolphin-does-not-have-mime-associations/48985
    # The file is copied from `$(nix eval --raw 'nixpkgs#kdePackages.plasma-workspace')/etc/xdg/menus/plasma-applications.menu`
    # I don't want to install more KDE stuff
    xdg.configFile."menus/applications.menu".source = ./dolphin/plasma-applications.menu;
  };
}
