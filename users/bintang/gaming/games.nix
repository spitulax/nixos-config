{ config
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    openrct2
    shattered-pixel-dungeon
  ];
}
