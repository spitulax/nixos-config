{ pkgs
, ...
}: {
  systemd.services.keymapperd = {
    enable = true;
    description = "Keymapper Daemon";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "exec";
      ExecStart = "${pkgs.mypkgs.keymapper}/bin/keymapperd -v";
      Restart = "always";
    };
  };
}
