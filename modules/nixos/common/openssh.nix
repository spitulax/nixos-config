{ outputs
, lib
, ...
}: {
  programs.ssh.startAgent = true;
  services.openssh = {
    enable = lib.mkDefault true;
    settings = {
      PasswordAuthentication = false;
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        # NOTE: add password to the rsa key
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
    ];
  };
  programs.ssh = {
    hostKeyAlgorithms = [
      "ssh-rsa"
      "ssh-ed25519"
    ];
    knownHosts = builtins.mapAttrs
      (name: _: {
        publicKeyFile = ../../../hosts/${name}/ssh_host_rsa_key.pub;
      })
      outputs.nixosConfigurations;
  };
}
