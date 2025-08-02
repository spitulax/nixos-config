{ config
, lib
, pkgs
, outputs
, ...
}:
let
  cfg = config.configs.mysql;
in
{
  imports = [
    outputs.nixosModules.mysql
  ];

  options.configs.mysql.enable = lib.mkEnableOption "MySQL";

  config = lib.mkIf cfg.enable {
    services.mysqlNoAutostart = {
      enable = true;
      package = pkgs.mariadb;
    };
  };
}
