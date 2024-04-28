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

    # Misc
    gnumake
    pkg-config
    jq
  ];
}
