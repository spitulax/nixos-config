{ pkgs
, ...
}: {
  hardware.steam-hardware.enable = true;
  programs.steam.enable = true;
  programs.steam.extraCompatPackages = [
    pkgs.proton-ge-bin
  ];
}
