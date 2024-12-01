{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.configs.vm;
in
{
  options.configs.vm = {
    enable = lib.mkEnableOption "virtualization tools";
    waydroid = lib.mkEnableOption "waydroid";
    qemuAllArch = lib.mkEnableOption "QEMU for other architectures";
  };

  config = lib.mkIf cfg.enable {
    boot.kernelModules = [ "vfio-pci" ];
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = if cfg.qemuAllArch then pkgs.qemu else pkgs.qemu_kvm;
        };
      };
      waydroid.enable = cfg.waydroid;
    };
    environment.systemPackages = with pkgs; [
      virt-manager
      virtiofsd
    ];
  };
}
