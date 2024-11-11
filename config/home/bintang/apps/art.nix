{ config
, pkgs
, lib
, ...
}: {
  options.configs.apps.art.enable = lib.mkEnableOption "art programs";

  config = lib.mkIf config.configs.apps.art.enable {
    home.packages = with pkgs; [
      krita
      lorien
    ];
  };
}
