{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.configs.apps.office;
in
{
  options.configs.apps.office = {
    enable = lib.mkEnableOption "LibreOffice";
    installSpellingDicts = lib.mkEnableOption "" // {
      description = "Whether to install spelling dictionaries.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice-fresh
      hunspell
    ] ++ lib.optionals cfg.installSpellingDicts [
      mypkgs.hunspell-id
    ] ++ (with pkgs.hunspellDicts; lib.optionals cfg.installSpellingDicts [
      en-gb-ize
      en-us
    ]);
  };
}
