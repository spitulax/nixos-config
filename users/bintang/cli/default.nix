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
    ./cava.nix
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
    chafa
    yt-dlp
    lexurgy
    exiftool
  ];
}
