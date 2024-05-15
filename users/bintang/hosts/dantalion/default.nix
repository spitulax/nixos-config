{ pkgs
, outputs
, ...
}: {
  imports = [
    ../../dev
    ../../env
    ../../cli
    ../../nvim
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
