{ config
, pkgs
, ...
}: {
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
  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ../keys/gpg1.asc;
        trust = 5;
      }
    ];
  };
}
