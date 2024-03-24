{ config
, pkgs
, ...
}: {
  imports = [
    ./keyboard.nix
    ./env.nix
    ./sops.nix
    ./entries.nix
    ./mime.nix
  ];

  home.packages = with pkgs; [
    ffmpeg
    jre8 # TODO: package lexurgy
    cloudflare-warp
  ];
}
