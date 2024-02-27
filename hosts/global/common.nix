{ pkgs
, lib
, inputs
, outputs
, config
, ...
}: {
  imports = [
    ./nix.nix
  ];

  programs.fish.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    nix-alien
    cachix
  ];
  programs.nix-ld.enable = true;

  # OpenSSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
  programs.ssh = {
    knownHosts = builtins.mapAttrs
      (name: _: {
        publicKeyFile = ../${name}/ssh_host_rsa_key.pub;
        extraHostNames = [ "localhost" ];
      })
      outputs.nixosConfigurations;
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;

  # Locales
  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.UTF-8";
    LC_IDENTIFICATION = "id_ID.UTF-8";
    LC_MEASUREMENT = "id_ID.UTF-8";
    LC_MONETARY = "id_ID.UTF-8";
    LC_NAME = "id_ID.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "id_ID.UTF-8";
    LC_TELEPHONE = "id_ID.UTF-8";
    LC_TIME = "id_ID.UTF-8";
  };

  # Sudo
  security.sudo = {
    execWheelOnly = true;
  };

  # Services
  services.dbus.packages = [ pkgs.gcr ];
}
