{ inputs
, config
, ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops.age.sshKeyPaths = map (x: x.path) config.services.openssh.hostKeys;
  sops.defaultSopsFile = ../../../secrets/global/secrets.yaml;
}
