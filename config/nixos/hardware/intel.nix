{ config
, lib
, pkgs
, ...
}:
{
  options.configs.hardware.intel.enable = lib.mkEnableOption "module for Intel CPUs and integrated GPUs";

  config = lib.mkIf config.configs.hardware.intel.enable {
    hardware.graphics.enable = lib.mkForce true;
    hardware.graphics.extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
    environment.systemPackages = with pkgs; [
      nvtopPackages.intel
      intel-gpu-tools
      libva-utils
      vdpauinfo
    ];

    # explicitly states what driver to use
    environment.variables = {
      LIBVA_DRIVER_NAME = "iHD";
      VDPAU_DRIVER = "va_gl";
    };
  };
}
