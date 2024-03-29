{ config
, ...
}: {
  sops = {
    age.sshKeyPaths = [ /home/bintang/.ssh/id_ed25519 ];
    defaultSopsFile = ../../../secrets/bintang/secrets.yaml;
  };
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];

  sops.secrets.gh-hosts = {
    sopsFile = ../../../secrets/bintang/gh.yaml;
    path = "${config.xdg.configHome}/gh/hosts.yml";
  };
}
