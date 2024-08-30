{ config
, outputs
, lib
, ...
}:
let
  cfg = config.configs.openssh;
in
{
  options.configs.openssh = {
    addHostKeys = lib.mkOption {
      type = lib.types.bool;
      description = "Generate rsa and ed25519 key for this host. Reminder to password protect the rsa key.";
    };

    passwordAuthentication = lib.mkEnableOption "password authentication (not recommended)";
  };

  config = {
    services.openssh = {
      enable = lib.mkDefault true;
      settings = {
        PasswordAuthentication = cfg.passwordAuthentication;
      };
      hostKeys = lib.optionals cfg.addHostKeys [
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
        {
          bits = 4096;
          path = "/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
      ];
    };

    programs.ssh = {
      startAgent = true;
      hostKeyAlgorithms = [
        "ssh-rsa"
        "ssh-ed25519"
      ];
      knownHosts = lib.mapAttrs
        (_: v: {
          publicKeyFile = v;
        })
        config.configs.requiredFiles.hostPublicKeys;
    };

    configs.requiredFiles = lib.optionalAttrs cfg.addHostKeys {
      hostPublicKeys = lib.mapAttrs
        (k: _: ../../../keys/hosts/${k}/ssh_host_rsa_key.pub)
        outputs.nixosConfigurations;
    };
  };
}
