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
          source = config.configs.requiredFiles.userGpgKey;
          trust = 5;
        }
      ];
    };

    configs.requiredFiles.userGpgKey = ../../../keys/users/bintang/gpg1.asc;
  };
}
