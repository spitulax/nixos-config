{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    gdb
    lldb
    valgrind
  ];
}
