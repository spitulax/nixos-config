{ config
, lib
, pkgs
, outputs
, ...
}:
let
  cfg = config.configs.sql;
in
{
  imports = [
    outputs.nixosModules.mysql
  ];

  options.configs.sql.enable = lib.mkEnableOption "SQL stuff";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      sqlite
      sqlitebrowser
    ];

    services.mysqlNoAutostart = {
      enable = true;
      package = pkgs.mariadb;
    };
  };
}
