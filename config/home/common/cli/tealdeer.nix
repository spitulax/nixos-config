{ config
, lib
, ...
}:
let
  cfg = config.configs.cli.tealdeer;
in
{
  options.configs.cli.tealdeer.enable = lib.mkEnableOption "Tealdeer" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
    programs.tealdeer.enable = true;
  };
}
