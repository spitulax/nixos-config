{ config
, pkgs
, ...
}: {
  imports = [
    ./font.nix
  ];

  # TODO: Move this later
  home.packages = with pkgs; [
    brave
    xclip
  ];
}
