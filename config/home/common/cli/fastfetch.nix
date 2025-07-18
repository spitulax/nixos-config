{ config
, lib
, pkgs
, ...
}: {
  options.configs.cli.fastfetch.enable = lib.mkEnableOption "fastfetch";

  config = lib.mkIf config.configs.cli.fastfetch.enable {
    home.packages = with pkgs; [
      fastfetch
    ];

    xdg.configFile."fastfetch".source = ./configs/fastfetch;
  };
}
