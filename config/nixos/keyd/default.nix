{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.keyd;

  inherit (builtins)
    readFile
    ;
in
{
  options.configs.keyd.enable = lib.mkEnableOption "keyd";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      keyd
    ];

    # FIXME: don't use C-fn
    environment.etc."keyd/default.conf".text = ''
      ${readFile ./default.conf}

      [control:C]
      f1=setlayout(main)
      f2=setlayout(my_ipa)
      f4=setlayout(my_bel)

      ${readFile ./belichian.conf}
      ${readFile ./ipa.conf}
    '';

    services.keyd.enable = true;
  };
}
