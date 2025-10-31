{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.perf;
in
{
  options.configs.perf.enable = lib.mkEnableOption "tracing commands with `perf`";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      perf
    ];
    boot.kernel.sysctl = {
      "kernel.perf_event_paranoid" = 0;
    };
  };
}
