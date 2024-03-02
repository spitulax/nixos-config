{ config
, pkgs
, ...
}: {
  home.packages = [ pkgs.fastfetch ];
}
