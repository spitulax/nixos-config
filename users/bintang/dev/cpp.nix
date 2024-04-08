{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    (hiPrio gcc)
    clang
    clang-tools
  ];
}
