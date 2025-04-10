{ config
, lib
, outputs
, pkgs
, ...
}:
let
  cfg = config.configs.keymapper;

  key = input: output: { inherit input output; };

  numpadLayout = [
    { input = "M"; output = "0"; }
    { input = "J"; output = "1"; }
    { input = "K"; output = "2"; }
    { input = "L"; output = "3"; }
    { input = "U"; output = "4"; }
    { input = "I"; output = "5"; }
    { input = "O"; output = "6"; }
    { input = "7"; output = "7"; }
    { input = "8"; output = "8"; }
    { input = "9"; output = "9"; }
  ];

  numpadMappings =
    lib.flatten
      (
        # Numpad layout but registers as number row keys
        map
          (x: [
            {
              input = "Ext{ControlRight{${x.input}}}";
              output = "${x.output}";
            }
            {
              input = "Ext{ControlRight{Shift{${x.input}}}}";
              output = "Shift{${x.output}}";
            }
          ])
          numpadLayout
      );
in
{
  imports = [
    outputs.homeManagerModules.keymapper
  ];

  options.configs.keymapper = {
    enable = lib.mkEnableOption "keymapper";
  };

  config = lib.mkIf cfg.enable {
    services.keymapper = {
      enable = true;
      package = pkgs.mypkgs.keymapper;
      forwardModifiers = [ "ShiftLeft" "ShiftRight" "ControlLeft" "ControlRight" "AltLeft" ];
      aliases = {
        "Super" = "Meta";
        "Ext" = "ContextMenu";
      };
      contexts = [
        {
          mappings = [
            (key "AltRight" "AltLeft")
            (key "ScrollLock" "CapsLock")
            (key "CapsLock" "Escape")
          ]
          ++ numpadMappings
          ++ [
            (key "Ext{Shift{N}}" "Control{Backspace}")
            (key "Ext{Shift{B}}" "Control{Delete}")
            (key "Ext{AltRight}" "AltRight")
            (key "Ext{K}" "ArrowUp")
            (key "Ext{J}" "ArrowDown")
            (key "Ext{H}" "ArrowLeft")
            (key "Ext{L}" "ArrowRight")
            (key "Ext{A}" "Home")
            (key "Ext{E}" "End")
            (key "Ext{U}" "PageUp")
            (key "Ext{D}" "PageDown")
            (key "Ext{M}" "Enter")
            (key "Ext{N}" "Backspace")
            (key "Ext{B}" "Delete")
            (key "Ext{T}" "Tab")

            (key "Ext{G}" "select_all")
            (key "Ext{C}" "edit_copy")
            (key "Ext{V}" "edit_paste")
            (key "Ext{X}" "edit_cut")
            (key "Ext{Minus}" "zoom_out")
            (key "Ext{Equal}" "zoom_in")
            (key "Ext{Backspace}" "zoom_reset")
            (key "Ext{Comma}" "nav_previous")
            (key "Ext{Period}" "nav_next")
            (key "Ext{Q}" "nav_close")

            (key "Ext" "")
            (key "Ext{Any}" "")

            (key "select_all" "Control{A}")
            (key "edit_copy" "Control{C}")
            (key "edit_paste" "Control{V}")
            (key "edit_cut" "Control{X}")
          ];
        }
        {
          class = "kitty";
          mappings = [
            (key "edit_copy" "Control{Shift{C}}")
            (key "edit_paste" "Control{Shift{V}}")
            (key "zoom_in" "Control{Shift{Equal}}")
            (key "zoom_out" "Control{Shift{Minus}}")
            (key "zoom_reset" "Control{Shift{Backspace}}")
          ];
        }
        {
          class = "/brave-.*|org\\.kde\\.dolphin|org\\.kde\\.gwenview|org\\.kde\\.okular/";
          mappings = [
            (key "nav_previous" "Control{Shift{Tab}}")
            (key "nav_next" "Control{Tab}")
            (key "nav_close" "Control{W}")
            (key "zoom_in" "Control{Shift{Equal}}")
            (key "zoom_out" "Control{Minus}")
            (key "zoom_reset" "Control{0}")
          ];
        }
      ];
      systemd = {
        enable = true;
        tray = false;
        wantedBy = [ ];
      };
    };
  };
}
