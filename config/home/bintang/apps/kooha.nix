{ config
, pkgs
, lib
, ...
}: {
  options.configs.apps.kooha.enable = lib.mkEnableOption "Kooha screen recorder";

  config = lib.mkIf config.configs.apps.kooha.enable {
    home.packages = with pkgs; [
      kooha
    ];
  };
}
