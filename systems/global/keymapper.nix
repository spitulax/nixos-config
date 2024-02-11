# https://github.com/Lillecarl/nixos/blob/master/common/keymapper.nix

{ pkgs
, config
, ...
}: {
  services.keymapper = {
    enable = true;
    extraArgs = [ "-v" ];
  };

  # Found that keymapperd can get stuck in a loop and eat up CPU
  systemd = {
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
          systemctl restart keymapperd
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
  };
}
