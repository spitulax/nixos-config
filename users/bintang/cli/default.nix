{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./fish
    ./starship
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
    gh
    nix-output-monitor
  ];
}
