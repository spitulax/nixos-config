{ config
, lib
, pkgs
, ...
}: {
  # TODO: `programs.lutris`
  options.configs.gaming.lutris.enable = lib.mkEnableOption "Lutris";

  config = lib.mkIf config.configs.gaming.lutris.enable {
    home.packages = with pkgs; [
      lutris
    ];
  };
}
