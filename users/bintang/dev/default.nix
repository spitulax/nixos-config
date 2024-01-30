{ config
, pkgs
, ...
}: {
  imports = [
    ./nvim
    ./python.nix
  ];

  home.packages = with pkgs; [
    # Development tools
    gf

    # Languages
    gcc
    lua

    # LSPs
    lua-language-server

    # Misc
    gnumake
    nodejs
  ];
}
