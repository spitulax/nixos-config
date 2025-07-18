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
    configureMime = lib.mkEnableOption "" // {
      description = "Whether to open certain files with office.";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        libreoffice-fresh
        hunspell
      ] ++ lib.optionals cfg.installSpellingDicts [
        mypkgs.hunspell-id
      ] ++ (with pkgs.hunspellDicts; lib.optionals cfg.installSpellingDicts [
        en-gb-ise
        en-us
      ]);
    })

    (lib.mkIf (cfg.enable && cfg.configureMime) {
      configs.apps.mime = {
        wordDoc = "writer.desktop";
        slideshowDoc = "impress.desktop";
        spreadsheetDoc = "calc.desktop";
      };
    })
  ];
}
