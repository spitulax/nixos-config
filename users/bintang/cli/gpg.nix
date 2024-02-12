{ config
, pkgs
, ...
}: {
  home.packages = with pkgs; [ pinentry-gnome gcr ];
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "7A7FDDEBBF361CDA7C09C470ECE1F17BBDA22717" ];
    pinentryFlavor = "gnome3";
    enableExtraSocket = true;
  };
  programs.gpg = {
    enable = true;
    settings = {
      trust-model = "tofu+pgp";
    };
    publicKeys = [
      {
        source = ../keys/gpg1.asc;
        trust = 5;
      }
    ];
  };
}
