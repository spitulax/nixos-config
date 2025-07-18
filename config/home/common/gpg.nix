{ config
, lib
, ...
}: {
  options.configs.gpg.enable = lib.mkEnableOption "GnuPG";

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
