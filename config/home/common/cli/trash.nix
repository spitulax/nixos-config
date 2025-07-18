{ config
, lib
, pkgs
, ...
}: {
  options.configs.cli.trash.enable = lib.mkEnableOption "trash-cli" // {
    default = true;
  };

  config = lib.mkIf config.configs.cli.trash.enable {
    home.packages = with pkgs; [
      trash-cli
    ];

    configs.cli.aliases.extraAliases = {
      rm = "trash-put -iv";
      restore = "trash-restore";
    };
  };
}
