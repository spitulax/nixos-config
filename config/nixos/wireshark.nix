{ config
, lib
, ...
}:
let
  cfg = config.configs.wireshark;
in
{
  options.configs.wireshark.enable = lib.mkEnableOption "wireshark";

  config = lib.mkIf cfg.enable {
    programs.wireshark.enable = true;
  };
}
