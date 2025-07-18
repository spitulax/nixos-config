{ config
, lib
, ...
}: {
  options.configs.gpg.enable = lib.mkEnableOption ''
    GnuPG.
    Put the public key at `/keys/users/${config.home.username}/gpg1.asc`
  '';

  config = lib.mkIf config.configs.gpg.enable {
    programs.gpg = {
      enable = true;
      publicKeys = [
        {
          source = ../../../keys/users/${config.home.username}/gpg1.asc;
          trust = 5;
        }
      ];
    };
  };
}
