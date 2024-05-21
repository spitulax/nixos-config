{ pkgs
, ...
}: {
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
}
