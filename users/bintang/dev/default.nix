{ config
, pkgs
, lib
, ...
}: {
  imports = [
    ./nvim
    ./python.nix
  ];

  home.packages = with pkgs; [
    # Debugger
    gf
    gdb

    # Languages
    (hiPrio gcc)
    clang
    lua

    # LSPs
    lua-language-server
    clang-tools

    # Misc
    gnumake
    nodejs

    # Man pages
    stdman
  ];
}
