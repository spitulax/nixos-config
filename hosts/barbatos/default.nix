{ lib
, pkgs
, outputs
, inputs
, config
, ...
}:
let
  hosts = outputs.nixosConfigurations;
in
{
  imports = with inputs; [
    home-manager.nixosModules.home-manager
    sops-nix.nixosModules.sops
    nixos-hardware.nixosModules.common-cpu-intel
    nixos-hardware.nixosModules.common-gpu-intel
    nixos-hardware.nixosModules.common-pc-laptop
    nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    nixos-hardware.nixosModules.common-pc-laptop-ssd
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    ./hardware-configuration.nix
    ../global
    ../users/bintang.nix
    ../features/desktop.nix
    ../features/gaming.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  # Home Manager
  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  # Sops
  sops.age.sshKeyPaths = [ /etc/ssh/ssh_host_ed25519_key ];
  sops.defaultSopsFile = ../../secrets/global/secrets.yaml;

  # Hardware
  hardware.opengl.enable = true;
  hardware.enableRedistributableFirmware = true;
  boot.kernelModules = [ "synaptics_usb" ];
  services.thermald.enable = true;
  hardware.videoAccel.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  environment.etc."bluetooth/audio.conf".text = ''
    [General]
    Enable=Source
  '';

  # Input device
  services.xserver.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = "0.4";
      tapping = false;
    };
    touchpad = {
      accelProfile = "adaptive";
      accelSpeed = "0.4";
      disableWhileTyping = true;
      naturalScrolling = true;
      tapping = true;
      tappingButtonMap = "lrm";
      tappingDragLock = true;
    };
  };

  # Networking
  networking.hostName = "barbatos";
  networking.networkmanager.enable = true;

  # Sounds
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    lowLatency = {
      enable = true;
      quantum = 64;
      rate = 48000;
    };
  };

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
      hosts;
  };

  # Misc programs
  environment.systemPackages = with pkgs; [
    # hardware monitoring
    inxi
    glxinfo
    lm_sensors
    libva-utils
    pciutils
    vdpauinfo
    intel-gpu-tools
    xorg.xdpyinfo
  ];

  # Misc services
  services.printing.enable = true;

  # State version
  system.stateVersion = "23.11";
}
