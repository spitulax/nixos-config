{ lib
, pkgs
, outputs
, inputs
, config
, ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../users/bintang.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  security.sudo.wheelNeedsPassword = false;
  programs.fish.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "astaroth";
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
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Nix
  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc =
    lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +3";
    };
  };

  # Display
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.defaultSession = "plasma";
    desktopManager.plasma5.enable = true;
  };
  xdg.portal.enable = true;

  # Virtualization
  virtualisation.vmware.guest.enable = true;

  # State version
  system.stateVersion = "23.11";
}
