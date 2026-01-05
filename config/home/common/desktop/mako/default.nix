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
    simple = lib.mkEnableOption "simpler config";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libnotify
    ];

    services.mako = {
      enable = true;

      settings =
        if cfg.simple then {
          max-history = 50;
          on-button-left = "exec ${pkgs.mako}/bin/makoctl menu -n \"$id\" -- ${pkgs.tofi}/bin/tofi --prompt-text 'Select action'";
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
        } else {
          max-history = 50;
          on-button-left = "exec ${pkgs.mako}/bin/makoctl menu -n \"$id\" ${pkgs.rofi}/bin/rofi -dmenu -p 'Select action'";
          on-button-middle = "dismiss-all";
          on-button-right = "dismiss";
          on-notify = "exec mpv /run/current-system/sw/share/sounds/freedesktop/stereo/message.oga";
          font = "sans-serif 12";
          background-color = "#313244CC";
          border-color = "#6c7086CC";
          border-radius = 12;
          progress-color = "over #585b70CC";
          format = "<i><b>%a</b></i> ⋅ <b>%s</b>\\n<small>%b</small>";
          default-timeout = 5000;
          ignore-timeout = 1;
          max-visible = 10;
          max-icon-size = 32;
          width = 400;
          height = 200;

          "urgency=low" = {
            text-color = "#6c7086";
            background-color = "#101020CC";
            on-notify = "none";
          };

          "urgency=normal" = {
            text-color = "#cdd6f4";
          };

          "urgency=critical" = {
            text-color = "#f38ba8";
            layer = "overlay";
            default-timeout = 0;
          };

          "urgency=critical body~=\"^www\\.youtube\\.com\"" = {
            text-color = "#cdd6f4";
            layer = "top";
            default-timeout = 5000;
          };

          "grouped" = {
            format = "(%g) <i><b>%a</b></i> ⋅ <b>%s</b>\\n<small>%b</small>";
          };

          "hidden" = {
            format = "%h notification(s) hidden";
          };

          "app-name=popup mode=do-not-disturb" = {
            invisible = 0;
          };

          "mode=do-not-disturb" = {
            invisible = 1;
            on-notify = "none";
          };

          "mode=do-not-disturb urgency=critical" = {
            invisible = 0;
          };

          "mode=do-not-disturb urgency=critical body~=\"^www\\.youtube\\.com\"" = {
            invisible = 1;
          };

          "app-name=popup" = {
            invisible = 0;
            layer = "overlay";
            width = 150;
            height = 150;
            anchor = "top-center";
            default-timeout = 1000;
            text-alignment = "center";
            on-button-left = "none";
            on-button-middle = "none";
            on-button-right = "none";
            on-notify = "none";
            ignore-timeout = 0;
            format = "<b>%s\\n%b</b>";
          };
        };
    };
  };
}
