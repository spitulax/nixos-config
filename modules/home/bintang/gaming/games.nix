{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    inputs.nix-gaming.osu-lazer-bin
  ];
}
