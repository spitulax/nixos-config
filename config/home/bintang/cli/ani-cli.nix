{ config
, pkgs
, lib
, ...
}: {
  options.configs.cli.ani-cli.enable = lib.mkEnableOption "ani-cli";

  config = lib.mkIf config.configs.cli.ani-cli.enable {
    home.packages = with pkgs; [
      ani-cli
    ];
  };
}
