{ config
, pkgs
, ...
}: {
  imports = [
    ./keyboard.nix
    ./env.nix
    ./sops.nix
  ];

  home.packages = with pkgs; [
    ffmpeg
  ];
}
