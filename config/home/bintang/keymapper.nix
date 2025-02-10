{ config
, lib
, outputs
, pkgs
, ...
}:
let
  cfg = config.configs.keymapper;
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
      forwardModifiers = [ "Shift" "Control" ];
      aliases = {
        "Alt" = "AltLeft";
        "AltGr" = "AltRight";
        "Super" = "Meta";
        "Ext" = "ContextMenu";
      };
      contexts = [
        {
          mappings = [
            { input = "AltGr"; output = "AltLeft"; }
            { input = "ScrollLock"; output = "CapsLock"; }
            { input = "CapsLock"; output = "Escape"; }

            { input = "Ext{AltGr}"; output = "AltGr"; }
            { input = "Ext{K}"; output = "ArrowUp"; }
            { input = "Ext{J}"; output = "ArrowDown"; }
            { input = "Ext{H}"; output = "ArrowLeft"; }
            { input = "Ext{L}"; output = "ArrowRight"; }
            { input = "Ext{A}"; output = "Home"; }
            { input = "Ext{E}"; output = "End"; }
            { input = "Ext{U}"; output = "PageUp"; }
            { input = "Ext{D}"; output = "PageDown"; }
            { input = "Ext{M}"; output = "Enter"; }
            { input = "Ext{N}"; output = "Backspace"; }
            { input = "Ext{Shift{N}}"; output = "Control{Backspace}"; }
            { input = "Ext{B}"; output = "Delete"; }
            { input = "Ext{Shift{B}}"; output = "Control{Delete}"; }

            { input = "Ext{V}"; output = "select_all"; }
            { input = "Ext{Y}"; output = "edit_copy"; }
            { input = "Ext{P}"; output = "edit_paste"; }
            { input = "Ext{X}"; output = "edit_cut"; }
            { input = "Ext{Minus}"; output = "zoom_out"; }
            { input = "Ext{Equal}"; output = "zoom_in"; }
            { input = "Ext{Backspace}"; output = "zoom_reset"; }
            { input = "Ext{Comma}"; output = "nav_previous"; }
            { input = "Ext{Period}"; output = "nav_next"; }
            { input = "Ext{Q}"; output = "nav_close"; }

            { input = "Ext"; output = ""; }
            { input = "Ext{Any}"; output = ""; }

            { input = "select_all"; output = "Control{A}"; }
            { input = "edit_copy"; output = "Control{C}"; }
            { input = "edit_paste"; output = "Control{V}"; }
            { input = "edit_cut"; output = "Control{X}"; }
          ];
        }
        {
          class = "kitty";
          mappings = [
            { input = "edit_copy"; output = "Control{Shift{C}}"; }
            { input = "edit_paste"; output = "Control{Shift{V}}"; }
            { input = "zoom_in"; output = "Control{Shift{Equal}}"; }
            { input = "zoom_out"; output = "Control{Shift{Minus}}"; }
            { input = "zoom_reset"; output = "Control{Shift{Backspace}}"; }
          ];
        }
        {
          class = "/brave-.*|org\\.kde\\.dolphin|org\\.kde\\.gwenview|org\\.kde\\.okular/";
          mappings = [
            { input = "nav_previous"; output = "Control{Shift{Tab}}"; }
            { input = "nav_next"; output = "Control{Tab}"; }
            { input = "nav_close"; output = "Control{W}"; }
            { input = "zoom_in"; output = "Control{Shift{Equal}}"; }
            { input = "zoom_out"; output = "Control{Minus}"; }
            { input = "zoom_reset"; output = "Control{0}"; }
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
