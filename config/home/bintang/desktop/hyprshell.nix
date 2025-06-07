{ config
, lib
, inputs
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.hyprshell;
in
{
  imports = [
    inputs.hyprshell.homeModules.hyprshell
  ];

  options.configs.desktop.hyprshell = {
    enable = lib.mkEnableOption "Hyprshell";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprshell = {
      enable = true;
      package = pkgs.hyprshell;
      systemd.target = "graphical-session.target";
      settings = {
        layerrules = true;
        kill_bind = "ctrl+shift+alt, h";
        launcher = {
          enable = false;
          # default_terminal = "kitty";
          # width = 650;
          # max_items = 10;
          # show_when_empty = true;
          # animate_launch_ms = 250;
          # plugins = {
          #   applications = {
          #     run_cache_weeks = 4;
          #     show_execs = true;
          #   };
          #   calc.enable = true;
          #   shell.enable = true;
          #   terminal.enable = true;
          #   websearch.enable = false;
          # };
        };
        windows = {
          scale = 8.5;
          workspaces_per_row = 5;
          strip_html_from_workspace_title = true;
          overview = {
            open = {
              key = "tab";
              modifier = "super";
            };
            navigate = {
              forward = "tab";
              reverse = {
                key = "grave";
                mod = null;
              };
            };
          };
          switch = {
            open.modifier = "alt";
            navigate = {
              forward = "tab";
              reverse = {
                key = "grave";
                mod = null;
              };
            };
          };
        };
      };
    };
  };
}

