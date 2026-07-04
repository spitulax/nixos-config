{ config
, lib
, ...
}:
let
  cfg = config.configs.apps.discord;
in
{
  options.configs.apps.discord.enable = lib.mkEnableOption "Discord";

  config = lib.mkIf cfg.enable {
    programs.vesktop = {
      enable = true;
    };
  };
}
