{ config
, pkgs
, ...
}: {
  imports = [
    ./syncthing
    ./fusuma.nix
    ./keymapper.nix
    ./dunst.nix
  ];

  home.packages = with pkgs; [
    keymapper
  ];
}
