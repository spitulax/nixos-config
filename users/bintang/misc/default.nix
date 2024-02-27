{ config
, pkgs
, ...
}: {
  imports = [
    ./keyboard.nix
    ./env.nix
    ./sops.nix
    ./nix.nix
  ];

  home.packages = with pkgs; [
    ffmpeg
    jre8
    cloudflare-warp
  ];
}
