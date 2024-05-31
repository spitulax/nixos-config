{ pkgs
, outputs
, ...
}: {
  imports = with outputs.homeModules.bintang;
    (with cli; [
      ani-cli
      default
      fish
      # gh
      git
      # gpg
      neofetch
      # ssh
      tmux
    ])
    ++
    (with dev; [
      lua
      nix
      python
      tools
    ])
    ++
    [
      env
      nix
      nvim
      # sops
    ];

  # User info
  home = {
    sessionVariables = {
      ROOT = "/data/data/com.termux.nix/files";
      STORAGE = "/storage/emulated/0";
    };
    stateVersion = "23.11";
  };

  nixpkgs = {
    inherit (outputs.pkgsFor.aarch64-linux) config overlays;
  };

  # Packages
  home.packages = with pkgs; [
    wget
    curl
    rsync
    tldr
  ];

  programs.home-manager.enable = true;
}
