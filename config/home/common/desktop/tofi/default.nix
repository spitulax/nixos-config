{ config
, lib
, ...
}:
let
  cfg = config.configs.desktop.tofi;
in
{
  options.configs.desktop.tofi.enable = lib.mkEnableOption "tofi";

  config = lib.mkIf cfg.enable {
    programs.tofi.enable = true;
  };
}
