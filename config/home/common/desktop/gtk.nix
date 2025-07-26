{ config
, pkgs
, lib
, ...
}:
let
  extraConfig = {
    gtk-decoration-layout = ":menu";
  };
in
{
  config = lib.mkIf config.configs.desktop.enable {
    home.packages = with pkgs; [
      nwg-look
    ];

    # TODO: global theming (gtk)
    gtk = {
      enable = true;
      theme = {
        package = pkgs.fluent-gtk-theme.override {
          tweaks = [ "round" ];
          colorVariants = [ "dark" ];
        };
        name = "Fluent-round-Dark";
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
      font = {
        name = "sans-serif";
        size = 10;
      };
      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      gtk3.extraConfig = extraConfig;
      gtk4.extraConfig = extraConfig;
      gtk2.extraConfig = ''
        gtk-enable-animations=1
        gtk-primary-button-warps-slider=0
        gtk-toolbar-style=3
        gtk-menu-images=1
        gtk-button-images=1
      '';
    };

    dconf.settings."org/gnome/desktop/wm/preferences".button-layout = extraConfig.gtk-decoration-layout;
  };
}
