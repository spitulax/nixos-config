{ pkgs
, ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      (rofi-emoji.override {
        rofi-unwrapped = rofi-wayland-unwrapped;
      })
    ];
    terminal = "${pkgs.kitty}/bin/kitty";
    theme = "catppuccin-mocha";
    location = "center";
    extraConfig = {
      modi = "run,drun,window";
      icon-theme = "Papirus-Dark";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = " 󰣆  Apps ";
      display-run = " 󰌧  Run ";
      display-window = " 󰖲  Window";
      display-emoji = "   Emoji";
      display-clipboard = " 󰅇  Clipboard";
      sidebar-mode = true;
    };
  };

  xdg.dataFile."rofi/themes/catppuccin-mocha.rasi".source = ./catppuccin-mocha.rasi;
  xdg.configFile."rofi/modes" = {
    source = ./modes;
    recursive = true;
  };
}
