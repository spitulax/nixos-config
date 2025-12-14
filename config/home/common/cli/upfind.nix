{ config
, lib
, pkgs
, ...
}:
let
  script = pkgs.writeShellScriptBin "upfind" ''
    DIR=$(readlink -f "$1")
    while
        RESULT=$(find "$DIR"/ -maxdepth 1 "''${@:2}")
        [[ -z $RESULT ]] && [[ "$DIR" != "/" ]]
    do DIR=$(dirname "$DIR"); done
    realpath --relative-to="$1" "$RESULT"
  '';
in
{
  options.configs.cli.upfind.enable = lib.mkEnableOption "upfind";

  config = lib.mkIf config.configs.cli.upfind.enable {
    home.packages = [
      script
    ];
  };
}
