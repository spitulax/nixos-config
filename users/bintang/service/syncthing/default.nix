{ config
, pkgs
, lib
, ...
}: {
  home.sessionVariables = {
    STCONFDIR = "$XDG_CONFIG_HOME/syncthing";
    STDATADIR = "$XDG_DATA_HOME/syncthing";
    STNODEFAULTFOLDER = "";
  };
  home.packages = [ pkgs.syncthingtray ];

  services.syncthing = {
    enable = true;
    tray = {
      enable = true;
      package = pkgs.syncthingtray;
      command = "syncthingtray";
    };
  };

  # Use the web app
  # xdg.desktopEntries = lib.mkIf config.services.syncthing.enable {
  #   syncthing = {
  #     type = "Application";
  #     name = "Syncthing";
  #     comment = "Sync files between hosts";
  #     exec = "syncthing --browser-only";
  #     icon = "syncthing";
  #     terminal = false;
  #     categories = [ "Utility" ];
  #   };
  # };
}
