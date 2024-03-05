{ config
, pkgs
, ...
}: {
  imports = [
    ./fish.nix
    ./starship.nix
    ./git.nix
    ./gh.nix
    ./gpg.nix
    ./ssh.nix
    ./btop.nix
    ./neofetch.nix
    ./fastfetch.nix
    ./spotdl.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    # shell utils
    ripgrep
    wget
    curl
    eza
    fd
    fzf
    which
    file
    imagemagick
    cloc
    fontpreview
    tldr
    trash-cli
    bat
    mediainfo
    dust

    # monitoring
    htop

    # archives
    zip
    unzip
    xz
    p7zip

    # misc
    gnupg
    chafa # for telescope-media-files.nvim
    yt-dlp
  ];
}
