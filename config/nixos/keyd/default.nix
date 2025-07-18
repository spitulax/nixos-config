{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.keyd;
in
{
  options.configs.keyd.enable = lib.mkEnableOption "keyd";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      keyd
    ];

    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(ext, esc)";
              scrolllock = "capslock";
              rightalt = "leftalt";
              compose = "rightalt";
            };

            ext = {
              space = "esc";
              tab = "enter";
              f = "enter";
              k = "up";
              j = "down";
              h = "left";
              l = "right";
              w = "up";
              s = "down";
              a = "left";
              d = "right";
              q = "home";
              e = "end";
              z = "delete";
              x = "backspace";
            };

            "ext+shift" = {
              k = "pageup";
              j = "pagedown";
              w = "pageup";
              s = "pagedown";
              z = "C-delete";
              x = "C-backspace";
            };
          }
          // import ./ipa.nix
          // import ./belichian.nix
          // {
            control = {
              f1 = "setlayout(main)";
              f2 = "setlayout(my_ipa)";
              # TODO: Alphabet layout
              # f3 = "setlayout(my_alp)";
              f4 = "setlayout(my_bel)";
            };
          };
        };
      };
    };
  };
}
