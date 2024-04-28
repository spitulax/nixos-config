{ config
, ...
}: {
  xdg.desktopEntries = {
    screenshots = {
      name = "Screenshots";
      comment = "View the screenshots folder";
      exec = "xdg-open ${config.xdg.userDirs.extraConfig.XDG_SCREENSHOT_DIR}";
      icon = "folder";
      categories = [ "System" ];
      type = "Application";
    };
    notes = {
      name = "Notes";
      comment = "Open notes";
      exec = "nvim ${config.xdg.userDirs.extraConfig.XDG_NOTES_DIR}";
      terminal = true;
      icon = "folder-notes";
      categories = [ "Utility" ];
      type = "Application";
    };
  };
}
