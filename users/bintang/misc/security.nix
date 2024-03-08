{ config
, pkgs
, ...
}: {
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  home.packages = with pkgs; [ pinentry-gnome gcr ];
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
    enableExtraSocket = true;
    defaultCacheTtl = 604800; # 604800 secs = one week
    defaultCacheTtlSsh = 604800;
    maxCacheTtl = 604800;
    maxCacheTtlSsh = 604800;
  };
}
