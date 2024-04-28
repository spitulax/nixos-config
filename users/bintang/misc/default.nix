{ pkgs
, ...
}: {
  imports = [
    ./env.nix
  ];

  home.packages = with pkgs; [
    ffmpeg
  ];
}
