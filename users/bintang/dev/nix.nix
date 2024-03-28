{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    vulnix
    nurl
    nix-output-monitor
    sops
    statix
    (nh.override { inherit (pkgs) nix-output-monitor; })
  ];
}
