{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    man-pages
    (hiPrio gcc)
    clang
    clang-tools
  ];
}
