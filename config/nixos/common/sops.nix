{ inputs
, config
, lib
, outputs
, ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "${outputs.vars.hostsSecretsPath}/${config.networking.hostName}/secrets.yaml";
    age = {
      keyFile = /etc/age/host.txt;
      # sshKeyPaths = map (x: x.path) (lib.filter (x: x.type == "ed25519") config.services.openssh.hostKeys);
      sshKeyPaths = [ ];
    };
    gnupg.sshKeyPaths = [ ];
  };
}
