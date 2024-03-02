{ config
, lib
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
  };
}
