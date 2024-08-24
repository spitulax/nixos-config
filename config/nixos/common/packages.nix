{ config
, pkgs
, ...
}:
{
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
    exiftool
    nix-tree

    # monitoring
    htop
    iotop
    iftop
    powertop

    # archives
    zip
    unzip
    xz
    p7zip

    # system utils
    inxi
    cachix
    psmisc
    lm_sensors
    ethtool
    pciutils
    usbutils
    hdparm
    dmidecode
    parted
    acpi
  ] ++ config.configs.extraPackages;
  programs.nix-ld.enable = false;
  programs.fish.enable = true;
  programs.dconf.enable = true;
  environment.variables.EDITOR = "nvim";
}
