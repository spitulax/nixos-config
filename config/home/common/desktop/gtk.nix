{ config
, pkgs
, lib
, ...
}:
let
  extraConfig = {
    gtk-decoration-layout = ":menu";
  };

  gtkConfig = {
    # TEMP: 'rose-pine-gtk-theme' has been removed because it depended on 'gtk-engine-murrine', which was removed because it was unmaintained upstream and depended on GTK 2.
    # FIXME: Create my own rose-pine-gtk-theme derivation
    # See also config/nixos/desktop/display-manager.nix:22
    theme = {
      package = pkgs.tempPkgs.stable.rose-pine-gtk-theme;
      name = "rose-pine";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    font = {
      name = "sans-serif";
      size = 10;
    };
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
      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      gtk3.extraConfig = extraConfig;
      gtk4 = {
        extraConfig = extraConfig;
      } // gtkConfig;
      gtk2.extraConfig = ''
        gtk-enable-animations=1
        gtk-primary-button-warps-slider=0
        gtk-toolbar-style=3
        gtk-menu-images=1
        gtk-button-images=1
      '';
    } // gtkConfig;

    dconf.settings."org/gnome/desktop/wm/preferences".button-layout = extraConfig.gtk-decoration-layout;
  };
}
