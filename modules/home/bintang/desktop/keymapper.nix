{ outputs
, pkgs
, ...
}: {
  imports = [
    outputs.homeManagerModules.keymapper
  ];

  services.keymapper = {
    enable = true;
    package = pkgs.mypkgs.keymapper;
    aliases = {
      "Alt" = "AltLeft";
      "AltGr" = "AltRight";
      "Super" = "Meta";
      "Ext" = "Backquote";
    };
    contexts = [
      {
        mappings = [
          { input = "Shift"; output = "Shift"; }
          { input = "Control"; output = "Control"; }
          { input = "Alt"; output = "Alt"; }
          { input = "Ext{AltGr}"; output = "AltGr"; }
          { input = "AltGr"; output = "Alt"; }
          { input = "ScrollLock"; output = "CapsLock"; }
          { input = "CapsLock"; output = "Escape"; }

          { input = "Ext"; output = "Backquote"; }
          { input = "Ext{Q}"; output = "Backquote"; }
          { input = "Ext{K}"; output = "ArrowUp"; }
          { input = "Ext{J}"; output = "ArrowDown"; }
          { input = "Ext{H}"; output = "ArrowLeft"; }
          { input = "Ext{L}"; output = "ArrowRight"; }
          { input = "Ext{A}"; output = "Home"; }
          { input = "Ext{E}"; output = "End"; }
          { input = "Ext{U}"; output = "PageUp"; }
          { input = "Ext{D}"; output = "PageDown"; }
          { input = "Ext{N}"; output = "Backspace"; }
          { input = "Ext{M}"; output = "Enter"; }
          { input = "Ext{B}"; output = "Delete"; }
          { input = "Ext{Y}"; output = "edit_copy"; }
          { input = "Ext{P}"; output = "edit_paste"; }
          { input = "Ext{X}"; output = "edit_cut"; }
          { input = "Ext{Minus}"; output = "zoom_out"; }
          { input = "Ext{Equal}"; output = "zoom_in"; }
          { input = "Ext{Backspace}"; output = "zoom_reset"; }
          { input = "Ext{Any}"; output = ""; }

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
        class = "/brave-browser|com.rtosta.zapzap|org.kde.dolphin/";
        mappings = [
          { input = "zoom_in"; output = "Control{Shift{Equal}}"; }
          { input = "zoom_out"; output = "Control{Minus}"; }
          { input = "zoom_reset"; output = "Control{0}"; }
        ];
      }
      {
        class = "org.https://nomacs.";
        mappings = [
          { input = "zoom_in"; output = "Control{Shift{Equal}}"; }
          { input = "zoom_out"; output = "Control{Minus}"; }
          { input = "zoom_reset"; output = "Control{0}"; }
        ];
      }
    ];
    systemd = {
      enable = true;
      tray = false;
    };
  };
}
