{ config
, pkgs
, lib
, ...
}: {
  options.configs.apps.anki.enable = lib.mkEnableOption "Anki";

  config = lib.mkIf config.configs.apps.anki.enable {
    home.packages = with pkgs; [
      anki
    ];
  };
}
