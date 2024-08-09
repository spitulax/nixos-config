{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    winetricks
  ] ++ (with pkgs.inputs.nix-gaming; [
    wine-ge
  ]);
}
