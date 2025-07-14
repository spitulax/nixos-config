{ pkgs
, lib
, ...
}:
let
  cacheTime = 1 * 7 * 24 * 60 * 60;
in
{
  security.polkit.enable = true;
  services.gnome = {
    gnome-keyring.enable = true;
    gcr-ssh-agent.enable = false;
  };
  environment.systemPackages = with pkgs; [
    gcr
    libsecret
  ];
  programs.seahorse.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-gnome3;
    enableExtraSocket = true;
    settings = {
      default-cache-ttl = cacheTime;
      default-cache-ttl-ssh = cacheTime;
      max-cache-ttl = cacheTime;
      max-cache-ttl-ssh = cacheTime;
    };
  };
}
