# Fixes the problem with hardware video acceleration not working in my laptop.
# Currently only works for Intel HD Graphics series Broadwell (2014) or newer.
# https://wiki.archlinux.org/title/Hardware_video_acceleration
{ config
, lib
, pkgs
, ...
}: {
  options.configs.videoHardwareIntel.enable = lib.mkEnableOption "hardware video acceleration for Intel integrated GPUs";

  config = lib.mkIf config.configs.videoHardwareIntel.enable {
    hardware.graphics.enable = lib.mkForce true;
    hardware.graphics.extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
    environment.systemPackages = with pkgs; [
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
