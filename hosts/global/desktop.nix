{ config
, pkgs
, ...
}: {
  imports = [
    ./common.nix
    ./sound.nix
    ./bluetooth.nix
    ./input.nix
    ./flatpak.nix
    ./security.nix
  ];

  hardware.opengl.enable = true;
}
