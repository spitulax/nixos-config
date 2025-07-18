{ config
, lib
, pkgs
, ...
}: {
  options.configs.services.syncthing.enable = lib.mkEnableOption "Syncthing";

  config = lib.mkIf config.configs.services.syncthing.enable {
    home.sessionVariables = {
      STCONFDIR = "$XDG_CONFIG_HOME/syncthing";
      STDATADIR = "$XDG_DATA_HOME/syncthing";
      STNODEFAULTFOLDER = 1;
    };

    services.syncthing = {
      enable = true;
      tray = {
        enable = false;
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
  };
}
