{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };
  services.displayManager.defaultSession = "hyprland";
}
