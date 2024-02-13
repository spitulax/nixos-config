{ config
, inputs
, pkgs
, ...
}: {
  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
  };
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
}
