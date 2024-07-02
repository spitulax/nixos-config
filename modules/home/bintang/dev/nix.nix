{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    nil
    statix
    nixpkgs-fmt
  ];
}
