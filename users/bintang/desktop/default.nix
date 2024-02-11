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
  ];
}
