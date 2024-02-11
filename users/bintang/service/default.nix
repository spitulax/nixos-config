{ config
, pkgs
, ...
}: {
  imports = [
    ./fusuma.nix
    ./keymapper.nix
  ];

  home.packages = with pkgs; [
    keymapper
  ];
}
