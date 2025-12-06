{ config
, pkgs
, myLib
, ...
}:
let
  inherit (myLib.hmHelper)
    packages
    ;

  cfg = config.configs.gaming.games;

  modules = with pkgs; {
    osu = {
      desc = "Osu!";
      pkgs = [
        osu-lazer
      ];
    };

    mcpe = {
      desc = "MCPE (Minecraft Bedrock Edition)";
      pkgs = [
        mcpelauncher-ui-qt
      ];
    };

    minecraft = {
      desc = "Minecraft (Prism Launcher)";
      pkgs = [
        prismlauncher
      ];
    };
  };
in
{
  options.configs.gaming.games = packages.mkOptions { inherit modules; };

  config = {
    home.packages = packages.mkConfig { inherit modules cfg; };
  };
}
