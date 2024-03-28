{ pkgs
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
    luajit
    ruby
    go

    # Misc
    gnumake
    nodejs
    pkg-config
    jq
  ];
}
