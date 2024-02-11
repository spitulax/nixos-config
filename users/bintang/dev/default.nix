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
    ruby

    # LSPs
    lua-language-server
    clang-tools

    # Misc
    gnumake
    nodejs
  ];
}
