{ config
, lib
, inputs
, ...
}:
let
  cfg = config.configs.apps.kitty;
in
{
  options.configs.apps.kitty = {
    enable = lib.mkEnableOption "kitty terminal emulator";
    # TODO: global theming
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font.size = 12.0;
      font.name = "monospace";
      settings = {
        # Scrollback
        scrollback_indicator_opacity = 0;
        # Mouse
        mouse_hide_wait = -1;
        url_style = "straight";
        # Terminal bell
        enable_audio_bell = "no";
        bell_on_tab = "󰂚 ";
        # Window layout
        remember_window_size = "yes";
        enabled_layouts = "*";
        hide_window_decorations = "yes";
        # Tab bar
        tab_bar_min_tabs = 2;
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        # Color scheme
        background_opacity = "1.0";
        dynamic_background_opacity = "yes";
      };
      extraConfig = ''
        include ./theme.conf
        font_features FiraCodeNF-Reg +cv10 +ss01 +ss05 +ss04 +ss03 +ss02
        font_features FiraCodeNF-Bold +cv10 +ss01 +ss05 +ss04 +ss03 +ss02
      '';
    };

    home.file.".config/kitty/theme.conf".source = inputs.rose-pine-kitty + "/dist/rose-pine.conf";
  };
}
