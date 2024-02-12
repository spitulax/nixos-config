{ config
, pkgs
, ...
}: {
  imports = [
    ./syncthing
    ./fusuma.nix
    ./keymapper.nix
  ];

  home.packages = with pkgs; [
    keymapper
  ];
}
