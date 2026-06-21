{ config
, lib
, ...
}: {
  options.configs.server.enable = lib.mkEnableOption "server specific modules";

  imports = [
    ./seanime.nix
  ];

  config = lib.mkIf config.configs.server.enable { };
}
