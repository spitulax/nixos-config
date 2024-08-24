{ config
, lib
, ...
}: {
  options.configs.avahi.enable = lib.mkEnableOption "avahi";

  config = lib.mkIf config.configs.avahi.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        domain = true;
        userServices = true;
      };
    };
  };
}
