{
  programs.kitty = {
    enable = true;
    # theme = "Catppuccin-Mocha";
    font.size = 12.0;
    font.name = "monospace";
    settings = {
      # Scrollback
      scrollback_indicator_opacity = 0;
      # Mouse
      mouse_hide_wait = -1;
      url_style = "straight";
      # Terminal bell
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
      background_opacity = "0.8";
    };
    extraConfig = ''
      include ./theme.conf
      font_features FiraCodeNF-Reg +cv10 +ss01 +ss05 +ss04 +ss03 +ss02
      font_features FiraCodeNF-Bold +cv10 +ss01 +ss05 +ss04 +ss03 +ss02
    '';
  };

  # My custom Catppuccin-Mocha theme
  home.file.".config/kitty/theme.conf".text = ''
    foreground              #CDD6F4
    background              #101020
    selection_foreground    #101020
    selection_background    #F5E0DC
    cursor                  #F9E2AF
    cursor_text_color       #101020
    url_color               #F5E0DC
    active_border_color     #B4BEFE
    inactive_border_color   #6C7086
    bell_border_color       #F9E2AF
    wayland_titlebar_color system
    macos_titlebar_color system
    active_tab_foreground   #101020
    active_tab_background   #74C7EC
    inactive_tab_foreground #CDD6F4
    inactive_tab_background #181825
    tab_bar_background      #101020
    mark1_foreground #101020
    mark1_background #B4BEFE
    mark2_foreground #101020
    mark2_background #CBA6F7
    mark3_foreground #101020
    mark3_background #74C7EC
    color0 #45475A
    color8 #585B70
    color1 #F38BA8
    color9 #F38BA8
    color2  #A6E3A1
    color10 #A6E3A1
    color3  #F9E2AF
    color11 #F9E2AF
    color4  #89B4FA
    color12 #89B4FA
    color5  #F5C2E7
    color13 #F5C2E7
    color6  #94E2D5
    color14 #94E2D5
    color7  #BAC2DE
    color15 #A6ADC8
  '';
}
