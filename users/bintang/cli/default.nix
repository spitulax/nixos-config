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
    vulnix
    sops

    # monitoring
    htop

    # archives
    zip
    unzip
    xz
    p7zip

    # misc
    gnupg
    nix-output-monitor
    chafa # for telescope-media-files.nvim
    yewtube # youtube cli

    # hardware monitoring
    inxi
    glxinfo
    lm_sensors
    libva-utils
    pciutils
    vdpauinfo
    intel-gpu-tools
    xorg.xdpyinfo
  ];
}
