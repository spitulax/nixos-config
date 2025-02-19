{ config
, lib
, pkgs
, ...
}: {
  options.configs.wine.enable = lib.mkEnableOption "Wine";

  config = lib.mkIf config.configs.wine.enable {
    home.packages = with pkgs; [
      winetricks
      # TEMP:
    ] ++ (with pkgs.inputs.nix-gaming-temp; [
      wine-ge
    ]);
  };
}
