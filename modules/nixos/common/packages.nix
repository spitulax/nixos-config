{ pkgs
, ...
}: {
  environment.systemPackages = with pkgs; [
    # shell utils
    neovim
    wget
    curl
    fd
    fzf
    which
    file
    tldr
    git
    mediainfo
    lsof

    # monitoring
    htop
    iotop
    iftop
    nmon
    sysbench
    powertop

    # archives
    zip
    unzip
    xz
    p7zip

    # system utils
    inxi
    glxinfo
    xorg.xdpyinfo
    nix-alien
    cachix
    psmisc
    lm_sensors
    ethtool
    pciutils
    usbutils
    hdparm
    dmidecode
    parted
  ];
  programs.nix-ld.enable = true;
  programs.fish.enable = true;
  programs.dconf.enable = true;
  environment.variables.EDITOR = "nvim";
}
