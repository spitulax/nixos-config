{ pkgs
, inputs
, ...
}: {
  home.packages = with pkgs; [
    nurl
    nix-output-monitor
    sops
    statix
    nvd
    nixpkgs-fmt
    (nh.override { inherit (pkgs) nix-output-monitor nvd; })
    nix-update
    inputs.nixpkgs-update.packages.${pkgs.system}.nixpkgs-update
  ];
}
