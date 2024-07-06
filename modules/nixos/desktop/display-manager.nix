{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };
  services.displayManager.defaultSession = "hyprland";

  # https://discourse.nixos.org/t/login-keyring-did-not-get-unlocked-hyprland/40869/10
  security.pam.services.gdm-password.enableGnomeKeyring = true;
  environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";
}
