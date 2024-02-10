{ config
, pkgs
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
    # gcc # TODO: Use nix shell
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
