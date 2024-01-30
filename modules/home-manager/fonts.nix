{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.fontProfile;
in
{
  options.fontProfile = {
    enable = lib.mkEnableOption "font profile";
    fonts = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = null;
      description = "List of fonts to install";
      example = "[ pkgs.fira-code ]";
    };
    nerdFonts = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = null;
      description = "List of Nerd Font fonts to install";
      example = "[ FiraCode ]";
    };
    monospace = lib.mkOption {
      type = lib.types.str;
      default = null;
      description = "Family name of the monospace font";
    };
    serif = lib.mkOption {
      type = lib.types.str;
      default = null;
      description = "Family name of the serif font";
    };
    sansSerif = lib.mkOption {
      type = lib.types.str;
      default = null;
      description = "Family name of the sans serif font";
    };
  };

  config = lib.mkIf cfg.enable {
    fonts.fontconfig.enable = true;
    home.packages = cfg.fonts ++ [ (pkgs.nerdfonts.override { fonts = cfg.nerdFonts; }) ];
  };
}
