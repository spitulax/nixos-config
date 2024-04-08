{ pkgs
, ...
}: {
  imports = [
    ./python.nix
    ./rust.nix
    ./nix.nix
    ./go.nix
    ./cpp.nix
  ];

  home.packages = with pkgs; [
    # Debugger
    gdb
    lldb

    # Languages
    luajit
    ruby

    # Misc
    gnumake
    nodejs
    pkg-config
    jq
  ];
}
