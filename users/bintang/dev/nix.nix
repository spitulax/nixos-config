{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    vulnix
    nurl
    nix-output-monitor
    sops
    statix
    nvd
    (nh.override { inherit (pkgs) nix-output-monitor nvd; })
  ];
}
