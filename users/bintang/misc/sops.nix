{ config
, inputs
, pkgs
, ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
  };
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
}
