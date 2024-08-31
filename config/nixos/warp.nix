{ config
, lib
, pkgs
, ...
}: {
  options.configs.warp.enable = lib.mkEnableOption "Cloudflare Warp daemon";

  config = lib.mkIf config.configs.warp.enable {
    environment.systemPackages = with pkgs; [
      cloudflare-warp
    ];

    systemd.services.warp = {
      enable = true;
      description = "Cloudflare Warp";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "exec";
        ExecStart = "${pkgs.cloudflare-warp}/bin/warp-svc";
        Restart = "always";
      };
    };
  };
}
