{ pkgs
, ...
}: {
  imports = [
    ../../dev
    ../../misc
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

  # Packages
  home.packages = with pkgs; [
    wget
    curl
    rsync
    tldr
  ];

  programs.home-manager.enable = true;
}