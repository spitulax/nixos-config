{ config
, pkgs
, lib
, ...
}:
let
  inherit (lib)
    mkOption
    types
    mapAttrs
    attrValues
    flatten
    optionals
    mkEnableOption
    ;

  cfg = config.configs.desktop.fonts;
in
{
  options.configs.desktop.fonts = {
    cjkFonts = mkEnableOption "CJK fonts support";
    nerdFonts = mkEnableOption "Nerd Fonts";
    notoFonts = mkEnableOption "Noto Fonts for other languages";

    defaultFonts =
      let
        option = type: default: {
          ${type} = mkOption {
            type = types.listOf (types.submodule {
              options = {
                name = mkOption {
                  type = types.str;
                  description = "The font name.";
                };
                package = mkOption {
                  type = types.package;
                  description = "The package that provides the font.";
                };
              };
            });
            default = [ default ];
            description = "The default ${type} font.";
          };
        };
      in
      option "serif"
        {
          name = "Source Serif 3";
          package = pkgs.source-serif;
        }
      // option "sansSerif"
        {
          name = "Source Sans 3";
          package = pkgs.source-sans;
        }
      // option "monospace" (
        if cfg.nerdFonts
        then {
          name = "Iosevka Nerd Font";
          package = pkgs.nerd-fonts.iosevka;
        }
        else {
          name = "Iosevka";
          package = pkgs.iosevka;
        }
      )
      // option "emoji"
        {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-color-emoji;
        };

    defaultCjkFonts = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        noto-fonts-cjk-sans
      ];
      description = "The default CJK fonts (installed if `cjkFonts` is true).";
    };

    extraFonts = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "List of font packages to install.";
    };
  };

  config = {
    fonts = {
      fontDir.enable = true;

      fontconfig = {
        enable = true;
        defaultFonts =
          mapAttrs
            (_: v: map (x: x.name) v)
            cfg.defaultFonts;
      };

      packages =
        flatten
          (map
            (x: map (y: [ y.package ]) x)
            (attrValues
              cfg.defaultFonts))
        ++ cfg.extraFonts
        ++ optionals cfg.nerdFonts (with pkgs; [
          nerd-fonts.symbols-only
        ])
        ++ optionals cfg.cjkFonts cfg.defaultCjkFonts
        ++ optionals cfg.notoFonts [ pkgs.noto-fonts ];
    };
  };
}
