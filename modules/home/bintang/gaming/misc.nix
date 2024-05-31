{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    mangohud
    gamescope
  ];
}
