{ pkgs
, ...
}: {
  home.packages = builtins.attrValues pkgs.custom.scripts;
}
