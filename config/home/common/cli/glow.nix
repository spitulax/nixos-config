{ config
, lib
, pkgs
, ...
}: {
  options.configs.cli.glow.enable = lib.mkEnableOption "Glow markdown viewer";

  config = lib.mkIf config.configs.cli.glow.enable {
    home.packages = with pkgs; [
      glow
    ];

    xdg.configFile."glow".source = ./configs/glow;
  };
}
