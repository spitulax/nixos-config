{ pkgs
, lib
, config
, ...
}:
with lib;
let
  cfg = config.vm;
in
{
  options.vm = {
    enable = mkEnableOption "virtualization";
    waydroid = mkEnableOption "waydroid";
    qemuAllArch = mkEnableOption "QEMU for other architectures";
  };

  config = mkIf cfg.enable {
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
    ];
  };
}
