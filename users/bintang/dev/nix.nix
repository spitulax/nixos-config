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
  ] ++ [ inputs.nh.packages.${pkgs.system}.default ];
}
