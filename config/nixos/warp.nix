{ config
, lib
, ...
}: {
  options.configs.warp.enable = lib.mkEnableOption "Cloudflare Warp daemon";

  config = lib.mkIf config.configs.warp.enable {
    services.cloudflare-warp.enable = true;
  };
}
