{ config
, lib
, pkgs
, ...
}: {
  options.configs.wine.enable = lib.mkEnableOption "Wine";

  config = lib.mkIf config.configs.wine.enable {
    home.packages = with pkgs; [
      winetricks
    ] ++ [
      pkgs.inputs.nix-gaming.wine-ge
    ];
  };
}
