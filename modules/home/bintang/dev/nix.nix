{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    nil
    statix
    nixpkgs-fmt
    nixfmt-rfc-style
    nurl
  ];
}
