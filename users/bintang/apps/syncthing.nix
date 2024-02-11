{ config
, pkgs
, lib
, ...
}: {
  # @TODO: Add config.xml here
  # home.file.".config/syncthing/config.xml".source = ./config.xml;

  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  xdg.desktopEntries = lib.mkIf config.services.syncthing.enable {
    syncthing = {
      type = "Application";
      name = "Syncthing";
      comment = "Sync files between hosts";
      exec = "syncthing --browser-only";
      icon = "syncthing";
      terminal = false;
      categories = [ "Utility" ];
    };
  };
}
