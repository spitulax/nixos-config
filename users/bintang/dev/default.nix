{ config
, pkgs
, lib
, ...
}: {
  imports = [
    ./godot
    ./python.nix
    ./rust.nix
    ./nix.nix
  ];

  home.packages = with pkgs; [
    # Debugger
    gf
    gdb
    lldb

    # Languages
    (hiPrio gcc)
    clang
    lua
    ruby
    go

    # LSPs
    lua-language-server
    clang-tools
    gopls

    # Misc
    gnumake
    nodejs
    pkg-config
    jq
  ];
}
