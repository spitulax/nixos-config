{ config
, lib
, ...
}:
let
  cfg = config.configs.desktop.polkitAgent;
in
{
  options.configs.desktop.polkitAgent.enable = lib.mkEnableOption "polkit agent";

  config = lib.mkIf cfg.enable {
    services.polkit-gnome.enable = true;
  };
}
