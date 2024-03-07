{ pkgs
, inputs
, ...
}: {
  home.packages = with pkgs; [
    vulnix
    nurl
    nix-output-monitor
    sops
    statix
    (nh.override { nix-output-monitor = pkgs.nix-output-monitor; })
  ];
}
