{ config
, lib
, ...
}: {
  options.configs.apps.obs.enable = lib.mkEnableOption "OBS Studio";

  config = lib.mkIf config.configs.apps.obs.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
