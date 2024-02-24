{ config
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    openrct2
    openttd
    unciv
  ];
}
