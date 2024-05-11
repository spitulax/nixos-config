{ pkgs
, ...
}: {
  home.packages = [ pkgs.custom.scripts ];
}
