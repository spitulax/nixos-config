{ config
, pkgs
, ...
}: {
  imports = [
    ./font.nix
    ./gtk.nix
  ];

  # TODO: Move this later
  home.packages = with pkgs; [
    brave
    xclip
  ];
}
