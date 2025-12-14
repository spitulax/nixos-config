{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.openssh;

  hostPublicKeys =
    lib.optionalAttrs
      cfg.addHostKeys
      (lib.filterAttrs
        (_: v: v != null)
        (lib.mapAttrs
          (k: _:
            let
              path = ../../../keys/hosts/${k}/ssh-rsa.pub;
            in
            if builtins.pathExists path then path else null)
          pkgs.myArgs.nixosConfigurations));
in
{
  options.configs.openssh = {
    addHostKeys = lib.mkOption {
      type = lib.types.bool;
      description = "Generate rsa and ed25519 key for this host.";
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
          path = "/etc/ssh/ssh-ed25519";
          type = "ed25519";
        }
        {
          bits = 4096;
          path = "/etc/ssh/ssh-rsa";
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
      knownHosts =
        lib.mapAttrs
          (_: v: { publicKeyFile = v; })
          hostPublicKeys;
    };
  };
}
