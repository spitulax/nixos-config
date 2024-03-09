{ config
, pkgs
, ...
}:
let
  cacheTime = 1 * 7 * 24 * 60 * 60;
in
{
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [ pinentry-gnome gcr ];
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
    enableExtraSocket = true;
    settings = {
      default-cache-ttl = cacheTime;
      default-cache-ttl-ssh = cacheTime;
      max-cache-ttl = cacheTime;
      max-cache-ttl-ssh = cacheTime;
    };
  };
}
