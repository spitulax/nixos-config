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
    ./scripts.nix
  ];

  home.packages = with pkgs; [
    eza
    ripgrep
    imagemagick
    cloc
    fontpreview
    trash-cli
    bat
    dust
    chafa # for telescope-media-files.nvim
    yt-dlp
    ueberzugpp
  ];
}
