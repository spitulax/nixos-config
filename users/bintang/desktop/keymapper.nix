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
    contexts = [
      {
        mappings = {
          "Shift" = "Shift";
          "Control" = "Control";
          "AltLeft" = "AltLeft";
          "CapsLock" = "Escape";
          "ContextMenu" = "PrintScreen";
        };
      }
    ];
    systemd = {
      enable = true;
      tray = false;
    };
  };
}
