{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib)
    mkOption
    mkEnableOption
    mkPackageOption
    mkIf
    types
    getExe
    ;

  cfg = config.configs.server.seanime;
in
{
  options.configs.server.seanime = {
    enable = mkEnableOption "Seanime";

    package = mkPackageOption pkgs "seanime" { };

    user = mkOption {
      type = types.str;
      default = "seanime";
    };

    group = mkOption {
      type = types.str;
      default = "seanime";
    };

    dataDir = mkOption {
      type = types.path;
      default = "/var/lib/seanime";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    systemd = {
      tmpfiles.settings.seanimeDirs = {
        "${cfg.dataDir}"."d" = {
          mode = "755";
          inherit (cfg) user group;
        };
      };
      services.seanime = {
        description = "Seanime media server";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        serviceConfig = {
          Type = "simple";
          User = cfg.user;
          Group = cfg.group;
          ExecStart = "${getExe cfg.package} --datadir '${cfg.dataDir}'";
          WorkingDirectory = cfg.dataDir;
          Restart = "on-failure";
          TimeoutSec = 15;
        };
      };
    };

    users.users = mkIf (cfg.user == "seanime") {
      seanime = {
        inherit (cfg) group;
        isSystemUser = true;
      };
    };

    users.groups = mkIf (cfg.group == "seanime") {
      seanime = { };
    };

    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [
        43211
      ];
    };
  };
}
