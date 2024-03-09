{ pkgs
, outputs
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
    ];
  };
  programs.ssh = {
    knownHosts = builtins.mapAttrs
      (name: _: {
        publicKeyFile = ../../../hosts/${name}/ssh_host_rsa_key.pub;
        extraHostNames = [ "localhost" ];
      })
      outputs.nixosConfigurations;
  };
}
