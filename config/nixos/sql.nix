{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.sql;
in
{
  options.configs.sql.enable = lib.mkEnableOption "SQL stuff";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      sqlite
      sqlitebrowser
    ];

    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

    systemd.services.mysql.wantedBy = lib.mkForce [ ];
  };
}
