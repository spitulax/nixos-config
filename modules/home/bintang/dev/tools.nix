{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    gnumake
    meson
    ninja
    pkg-config
    jq
  ];
}
