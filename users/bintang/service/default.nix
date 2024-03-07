{ config
, pkgs
, ...
}: {
  imports = [
    ./syncthing
    ./fusuma.nix
    ./keymapper.nix
    # ./dunst.nix # DEPRECATED
    ./mako.nix
  ];

  home.packages = with pkgs; [
    keymapper
  ];
}
