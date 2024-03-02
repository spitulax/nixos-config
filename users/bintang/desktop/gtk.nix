{ config
, pkgs
, ...
}:
let
  extraConfig = {
    gtk-application-prefer-dark-theme = true;
    gtk-decoration-layout = "close,minimize,maximize:menu";
  };
in
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.whitesur-gtk-theme.override {
        iconVariant = "tux";
      };
      name = "WhiteSur-Dark";
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    font = {
      name = config.fontProfile.sansSerif;
      size = 10;
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3.extraConfig = extraConfig;
    gtk4.extraConfig = extraConfig;
  };
}
