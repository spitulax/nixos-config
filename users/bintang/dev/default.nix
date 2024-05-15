{ pkgs
, myLib
, ...
}: myLib.importIn ./. // {

  home.packages = with pkgs; [
    # Debugger
    gdb
    lldb

    # Languages
    luajit

    # Misc
    gnumake
    pkg-config
    jq
  ];
}
