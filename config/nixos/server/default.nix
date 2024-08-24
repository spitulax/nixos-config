{ config
, lib
, ...
}: {
  options.configs.server.enable = lib.mkEnableOption "server specific modules";

  config = lib.mkIf config.configs.server.enable { };
}
