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
    ./spotdl.nix
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
    tmux
    fontpreview
    tldr
    trash-cli
    bat
    mediainfo

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
