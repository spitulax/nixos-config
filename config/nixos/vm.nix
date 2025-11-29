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
    qemu = lib.mkEnableOption "QEMU with KVM";
    waydroid = lib.mkEnableOption "waydroid";
    qemuAllArch = lib.mkEnableOption "QEMU for all architectures";
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.qemu || cfg.qemuAllArch) {
      boot.kernelModules = [ "vfio-pci" ];
      virtualisation = {
        libvirtd = {
          enable = true;
          qemu = {
            package = if cfg.qemuAllArch then pkgs.qemu else pkgs.qemu_kvm;
          };
        };
      };
      environment.systemPackages = with pkgs; [
        virt-manager
        virtiofsd
      ];
    })

    (lib.mkIf cfg.waydroid {
      virtualisation.waydroid.enable = true;
      # NOTE: No need to enable nftables module, but the non-nftables package will always not work.
      virtualisation.waydroid.package = pkgs.waydroid-nftables;
      systemd.services.waydroid-container.wantedBy = lib.mkForce [ ];
      # networking.nftables.enable = true;
    })
  ];
}
