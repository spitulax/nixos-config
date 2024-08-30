{ config
, lib
, ...
}: {
  options.configs.apps.entries.enable = lib.mkEnableOption "common desktop entries";

  config = lib.mkIf config.configs.apps.entries.enable {
    xdg.desktopEntries = {
      screenshots = {
        name = "Screenshots";
        comment = "View the screenshots folder";
        exec = "xdg-open ${config.xdg.userDirs.extraConfig.SCREENSHOT_DIR}";
        icon = "folder";
        categories = [ "System" ];
        terminal = true;
        type = "Application";
      };
      notes = {
        name = "Notes";
        comment = "Open notes";
        exec = "notes";
        terminal = true;
        icon = "folder-notes";
        categories = [ "Utility" ];
        type = "Application";
      };
    };
  };
}
