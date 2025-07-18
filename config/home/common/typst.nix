{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.typst;
in
{
  options.configs.typst.enable = lib.mkEnableOption "Typst";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      typst
      tinymist
      websocat
    ];
  };
}
