{ config
, lib
, ...
}: {
  options.configs.laptop.enable = lib.mkEnableOption "laptop specific modules";

  config = lib.mkIf config.configs.laptop.enable {
    services.logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandlePowerKey = "suspend";
      HandlePowerKeyLongPress = "poweroff";
    };
  };
}
