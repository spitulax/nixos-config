{ inputs
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    winetricks
  ] ++ (with inputs.nix-gaming.packages.${pkgs.system}; [
    wine-ge
  ]);
}
