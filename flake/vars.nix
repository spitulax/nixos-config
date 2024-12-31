{
  # Binary cache substituters
  substituters = [
    "https://cache.nixos.org"
    "https://nix-gaming.cachix.org"
    "https://hyprland.cachix.org"
    "https://nix-on-droid.cachix.org"
    "https://nix-community.cachix.org"
    "https://spitulax.cachix.org"
    "https://yazi.cachix.org"
  ];
  trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    "nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "spitulax.cachix.org-1:GQRdtUgc9vwHTkfukneFHFXLPOo0G/2lj2nRw66ENmU="
    "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
  ];

  globalSecretsPath = ../secrets/global;
  hostsSecretsPath = ../secrets/hosts;
  usersSecretsPath = ../secrets/users;

  commonPackage = pkgs: with pkgs; [
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
    inetutils
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
  ];
}
