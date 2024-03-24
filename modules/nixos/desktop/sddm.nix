{ pkgs
, inputs
, ...
}: {
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "chili";
    };
    displayManager.defaultSession = "hyprland";
  };

  environment.systemPackages = [
    pkgs.sddm-chili-theme
  ];
}
