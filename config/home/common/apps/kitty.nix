{ config
, lib
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

    # Taken from https://github.com/rose-pine/kitty/blob/main/dist/rose-pine.conf
    home.file.".config/kitty/theme.conf".text = ''
      ## name: Rosé Pine
      ## author: mvllow
      ## license: MIT
      ## upstream: https://github.com/rose-pine/kitty/blob/main/dist/rose-pine.conf
      ## blurb: All natural pine, faux fur and a bit of soho vibes for the classy minimalist

      foreground               #e0def4
      background               #191724
      selection_foreground     #e0def4
      selection_background     #403d52

      cursor                   #524f67
      cursor_text_color        #e0def4

      url_color                #c4a7e7

      active_tab_foreground    #e0def4
      active_tab_background    #26233a
      inactive_tab_foreground  #6e6a86
      inactive_tab_background  #191724

      active_border_color      #31748f
      inactive_border_color    #403d52

      # black
      color0   #26233a
      color8   #6e6a86

      # red
      color1   #eb6f92
      color9   #eb6f92

      # green
      color2   #31748f
      color10  #31748f

      # yellow
      color3   #f6c177
      color11  #f6c177

      # blue
      color4   #9ccfd8
      color12  #9ccfd8

      # magenta
      color5   #c4a7e7
      color13  #c4a7e7

      # cyan
      color6   #ebbcba
      color14  #ebbcba

      # white
      color7   #e0def4
      color15  #e0def4
    '';
  };
}
