{ inputs
, config
, outputs
, pkgs
, ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  home.packages = with pkgs; [
    sops
  ];

  sops = {
    defaultSopsFile = "${outputs.vars.usersSecretsPath}/bintang/secrets.yaml";
    age = {
      keyFile = config.xdg.dataHome + "/age/user.txt";
      # sshKeyPaths = [ (config.home.homeDirectory + "/.ssh/id_ed25519") ];
      sshKeyPaths = [ ];
    };
  };

  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
}
