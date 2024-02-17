{ config
, inputs
, pkgs
, ...
}: {
  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ../../../secrets/bintang/secrets.yaml;
  };
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
}
