{ config
, lib
, pkgs
, ...
}: {
  options.configs.keymapper.enable = lib.mkEnableOption "keymapper system daemon";

  config = lib.mkIf config.configs.keymapper.enable {
    systemd.services.keymapperd = {
      enable = true;
      description = "Keymapper Daemon";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "exec";
        ExecStart = "${pkgs.mypkgs.keymapper}/bin/keymapperd";
        Restart = "always";
      };
    };
  };
}
