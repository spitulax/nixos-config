{ config
, pkgs
, ...
}: {
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font.size = 12.0;
    font.name = config.fontProfile.monospace;
    settings = {
      # Mouse
      mouse_hide_wait = -1;
      url_style = "straight";
      # Terminal bell
      bell_on_tab = "󰂚 ";
      # Window layout
      remember_window_size = "yes";
      enabled_layouts = "*";
      hide_window_decorations = "no";
      # Tab bar
      tab_bar_min_tabs = 2;
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      # Color scheme
      background_opacity = "1.0";
    };
    extraConfig = ''
      font_features FiraCodeNF-Reg +cv10 +ss01 +ss05 +ss04 +ss03 +ss02
      font_features FiraCodeNF-Bold +cv10 +ss01 +ss05 +ss04 +ss03 +ss02
    '';
  };
}
