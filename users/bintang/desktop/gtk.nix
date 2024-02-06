{ config
, pkgs
, ...
}: {
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Adwaita";
      size = 24;
    };
    iconTheme.name = "breeze-dark";
    font = {
      name = config.fontProfile.sansSerif;
      size = 10;
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };
}
