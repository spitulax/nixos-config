{ pkgs
, ...
}: {
  home.packages = with pkgs.mypkgs; [
    odin-nightly
    ols
  ];
}
