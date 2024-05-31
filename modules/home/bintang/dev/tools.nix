{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    gnumake
    pkg-config
    jq
  ];
}
