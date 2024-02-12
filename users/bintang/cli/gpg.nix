{ config
, pkgs
, ...
}: {
  home.packages = with pkgs; [ pinentry-gnome gcr ];
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "E2FA80500B87C7C776802641F3AEC11D29A6E8A7" ];
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
        source = ../keys/gpg2.asc;
        trust = 5;
      }
      {
        source = ../keys/gpg1.asc;
        trust = 3;
      }
    ];
  };
}
