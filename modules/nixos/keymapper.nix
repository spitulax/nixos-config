# https://github.com/Lillecarl/nixos/blob/master/modules/nixos/keymapper.nix

{ pkgs
, lib
, config
, ...
}: {
  systemd = {
    # Found that keymapperd can get stuck in a loop and eat up CPU
    timers.keymapper-mon = {
      enable = true;
      wantedBy = [ "keymapper.service" ];
      timerConfig = {
        OnCalendar = "*-*-* *:*:00";
        AccuracySec = "60";
        Persistent = true;
      };
    };

    services.keymapper-mon = {
      enable = true;
      wantedBy = [ "keymapper.service" ];
      path = [
        config.systemd.package
        pkgs.procps
        pkgs.bc
        pkgs.coreutils
        pkgs.gawk
      ];
      script = ''
        cpu=$(ps -p $(pgrep keymapperd) -u --no-headers | awk '{ print $3 }' | bc)
        if test $cpu -gt 10; then
          systemctl restart keymapper
        fi
      '';
    };

    services.keymapper-restart = {
      enable = true;
      wantedBy = [ "post-resume.target" ];
      path = [
        config.systemd.package
      ];
      script = ''
        systemctl restart keymapper
      '';
    };

    services.keymapper = {
      enable = true;
      description = "Keymapper";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.keymapper}/bin/keymapperd -v";
        Restart = "always";
        RestartSec = "5";
      };
    };
  };
}
