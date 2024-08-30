{ config
, lib
, pkgs
, ...
}: {
  options.configs.apps.bottles.enable = lib.mkEnableOption "bottles";

  config = lib.mkIf config.configs.apps.bottles.enable {
    home.packages = with pkgs; [
      bottles
    ];
  };
}
