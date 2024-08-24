{ config
, lib
, pkgs
, ...
}: {
  options.configs.plasma.enable = lib.mkEnableOption "KDE Plasma";

  config = lib.mkIf config.configs.plasma.enable {
    # FAILED: upgrading to plasma 6 makes plasma appear as just black screen with cursor
    # nothing is loaded or interactable except mako
    # sddm theme is also not loaded
    # locking the screen/sleeping throws error saying ctrl+alt+f2 to lock because the plasma lockscreen cannot run
    # but pressing ctrl+alt+f2 will throw you to apparently sddm but it's uninteractable
    # pressing ctrl+alt+f3 will get you back to the black screen
    services.xserver.desktopManager.plasma5.enable = true;
    environment.plasma5.excludePackages = with pkgs.libsForQt5; [
      elisa
      ark
      gwenview
      konsole
      okular
    ];
  };
}
