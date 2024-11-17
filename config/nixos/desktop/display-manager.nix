{ config
, lib
, ...
}: {
  config = lib.mkIf config.configs.desktop.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
    };
    services.displayManager.defaultSession = config.configs.desktop.defaultSession;

    # https://discourse.nixos.org/t/login-keyring-did-not-get-unlocked-hyprland/40869/10
    # It still doesn't work
    security.pam.services.gdm-password.enableGnomeKeyring = true;
    environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";
  };
}
