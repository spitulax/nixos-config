{ config
, inputs
, outputs
, lib
, ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.configs.sops.enable = lib.mkEnableOption "sops";

  config = lib.mkIf config.configs.sops.enable {
    sops = {
      inherit (config.configs.requiredFiles) defaultSopsFile;
      age = {
        keyFile = config.configs.requiredFiles.ageKeyFile;
        # sshKeyPaths = map (x: x.path) (lib.filter (x: x.type == "ed25519") config.services.openssh.hostKeys);
        sshKeyPaths = [ ];
      };
      gnupg.sshKeyPaths = [ ];
    };

    configs.requiredFiles = {
      defaultSopsFile = /${outputs.vars.hostsSecretsPath}/${config.networking.hostName}/secrets.yaml;
      ageKeyFile = /etc/age/host.txt; # NOTE: needs root permission
    };
  };
}
