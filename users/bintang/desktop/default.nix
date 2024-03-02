{ config
, pkgs
, ...
}: {
  imports = [
    ./font.nix
    ./gtk.nix
  ];

  home.packages = with pkgs; [
    xclip
    wl-clipboard
    adwaita-qt
    kdePackages.kdialog
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.whitesur-cursors;
    name = "WhiteSur-cursors";
    size = 24;
  };
}
