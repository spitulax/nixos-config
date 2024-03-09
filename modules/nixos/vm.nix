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
    waydroid = mkEnableOption "waydroid";
    qemuAllArch = mkEnableOption "QEMU for other architectures";
  };

  config = {
    boot.kernelModules = [ "vfio-pci" ];
    virtualisation = {
      libvirtd.enable = true;
      waydroid.enable = cfg.waydroid;
    };
    environment.systemPackages = with pkgs; [
      virt-manager
      (qemu.override {
        hostCpuOnly = !cfg.qemuAllArch;
      })
    ];
  };
}
