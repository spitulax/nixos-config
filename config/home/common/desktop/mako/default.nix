{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.mako;
in
{
  options.configs.desktop.mako = {
    enable = lib.mkEnableOption "Mako notification daemon";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libnotify
    ];

    services.mako = {
      enable = true;

      # TODO: Global theming
      settings = {
        max-history = 50;
        on-button-left = "exec ${pkgs.mako}/bin/makoctl menu -n \"$id\" -- ${pkgs.tofi}/bin/tofi --config ~/.config/tofi/vertical --prompt-text 'Select action'";
        on-button-middle = "dismiss-all";
        on-button-right = "dismiss";
        background-color = "#191724";
        border-color = "#eb6f92";
        progress-color = "over #403d52";
        format = "<i><b>%a</b></i> ⋅ <b>%s</b>\\n<small>%b</small>";
        default-timeout = 5000;
        ignore-timeout = 1;
        max-visible = 10;
        max-icon-size = 32;
        width = 400;
        height = 200;

        "urgency=low" = {
          text-color = "#6e6a86";
          background-color = "#191724";
          border-color = "#524f67";
        };

        "urgency=normal" = {
          text-color = "#e0def4";
        };

        "urgency=critical" = {
          text-color = "#eb6f92";
          layer = "overlay";
          default-timeout = 0;
        };

        "grouped" = {
          format = "(%g) <i><b>%a</b></i> ⋅ <b>%s</b>\\n<small>%b</small>";
        };

        "hidden" = {
          format = "%h notification(s) hidden";
        };

        "mode=do-not-disturb" = {
          invisible = 1;
        };

        "mode=do-not-disturb urgency=critical" = {
          invisible = 0;
        };

        "app-name=popup" = {
          invisible = 0;
          layer = "overlay";
          width = 100;
          height = 150;
          anchor = "bottom-center";
          default-timeout = 1000;
          text-alignment = "center";
          on-button-left = "none";
          on-button-middle = "none";
          on-button-right = "none";
          on-notify = "none";
          ignore-timeout = 0;
          format = "<b>%s\\n%b</b>";
          text-color = "#e0def4";
          border-color = "#c4a7e7";
        };
      };
    };
  };
}
