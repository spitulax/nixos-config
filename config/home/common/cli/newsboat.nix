{ config
, lib
, ...
}:
let
  cfg = config.configs.cli.newsboat;
in
{
  options.configs.cli.newsboat.enable = lib.mkEnableOption "Newsboat feed reader";

  config = lib.mkIf cfg.enable {
    programs.newsboat = {
      enable = true;
      autoReload = true;
    };
  };
}
