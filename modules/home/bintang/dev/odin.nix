{ pkgs
, ...
}: {
  home.packages = with pkgs.mypkgs; [
    odin
    ols
  ];
}
