{ pkgs
, myLib
, ...
}: myLib.importIn ./. // {

  home.packages = with pkgs; [
    # Debugger
    gdb
    lldb
    valgrind

    # Languages
    luajit

    # Misc
    gnumake
    pkg-config
    jq
  ];
}
