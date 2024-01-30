{ config
, pkgs
, ...
}: {
  imports = [
    ./fish.nix
    ./starship.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    # shell utils
    ripgrep
    wget
    curl
    eza
    neofetch
    fd
    fzf
    which
    file
    imagemagick
    cloc
    tmux
    fontpreview
    tldr
    trash-cli
    bat

    # monitoring
    btop
    htop

    # archives
    zip
    unzip
    xz
    p7zip

    # misc
    gnupg
    nix-output-monitor
    chafa
  ];
}
