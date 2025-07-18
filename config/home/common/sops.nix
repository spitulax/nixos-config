{ config
, inputs
, outputs
, pkgs
, lib
, ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  options.configs.sops.enable = lib.mkEnableOption ''
    sops.
    Requires an age key in `$XDG_DATA_HOME/age/user.txt`
  '';

  config = lib.mkIf config.configs.sops.enable {
    home.packages = with pkgs; [
      sops
    ];

    sops = {
      defaultSopsFile = "${outputs.vars.usersSecretsPath}/${config.home.username}/secrets.yaml";
      age = {
        keyFile = config.xdg.dataHome + "/age/user.txt";
        # sshKeyPaths = [ (config.home.homeDirectory + "/.ssh/id_ed25519") ];
        sshKeyPaths = [ ];
      };
    };

    systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
  };
}
