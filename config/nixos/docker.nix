{ config
, lib
, ...
}:
let
  cfg = config.configs.docker;
in
{
  options.configs.docker.enable = lib.mkEnableOption "docker";

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
    };
  };
}
