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

  options.configs.sops.enable = lib.mkEnableOption ''
    sops.
    Requires an age key in `/var/lib/age/host.txt`.
    Must be enabled in order for the config to work
  '';

  config = lib.mkIf config.configs.sops.enable {
    sops = {
      defaultSopsFile = /${outputs.vars.hostsSecretsPath}/${config.configs.hostname}/secrets.yaml;
      age = {
        keyFile = "/var/lib/age/host.txt";
        # sshKeyPaths = map (x: x.path) (lib.filter (x: x.type == "ed25519") config.services.openssh.hostKeys);
        sshKeyPaths = [ ];
      };
      gnupg.sshKeyPaths = [ ];
    };
  };
}
