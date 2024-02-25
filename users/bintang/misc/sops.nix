{ config
, inputs
, pkgs
, ...
}: {
  sops = {
    age.sshKeyPaths = [ /home/bintang/.ssh/id_ed25519 ];
    defaultSopsFile = ../../../secrets/bintang/secrets.yaml;
  };
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
}
