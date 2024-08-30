{ config
, pkgs
, lib
, ...
}:
let
  inherit (lib)
    mapAttrs
    mkEnableOption
    flatten
    mapAttrsToList
    filterAttrs
    ;

  cfg = config.configs.gaming.games;

  games = with pkgs; {
    osu = [
      inputs.nix-gaming.osu-lazer-bin
    ];
  };
in
{
  options.configs.gaming.games =
    mapAttrs
      (k: _: mkEnableOption k)
      games;

  config = {
    home.packages =
      flatten
        (mapAttrsToList
          (k: _: games.${k})
          (filterAttrs
            (_: v: v)
            cfg));
  };
}
