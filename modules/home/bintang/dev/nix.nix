{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    nil
    nurl
    nix-output-monitor
    sops
    statix
    nvd
    nixpkgs-fmt
    (nh.override { inherit (pkgs) nix-output-monitor nvd; })
  ];
}
