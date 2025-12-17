{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.waybar;

  package = pkgs.waybar;
in
{
  imports = [
    ./trays.nix
  ];

  options.configs.desktop.waybar = {
    enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      inherit package;
    };

    configs.cli.timeinfo.enable = lib.mkDefault true;

    xdg.configFile = {
      "waybar/config.jsonc".source = ./config.jsonc;
      "waybar/style.css".source = ./style.css;
      "waybar/catppuccin-mocha.css".source = ./catppuccin-mocha.css;
      "waybar/scripts" = {
        source = ./scripts;
        recursive = true;
      };
    };

    # systemd.user.services.waybar = {
    #   Unit = {
    #     Description = "Wayland status bar";
    #     After = "graphical-session.target";
    #   };
    #   Service = {
    #     Type = "exec";
    #     ExecStart = "${lib.meta.getExe package}";
    #     ExecReload = "${pkgs.util-linux}/bin/kill -SIGUSR2 $MAINPID";
    #     Restart = "on-failure";
    #     Slice = "app-graphical.slice";
    #   };
    #   # Install.WantedBy = [ "graphical-session.target" ];
    # };
  };
}
