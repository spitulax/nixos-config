# Fixes the problem with hardware video acceleration not working in my laptop.
# Currently only works for Intel HD Graphics series Broadwell (2014) or newer.
# https://wiki.archlinux.org/title/Hardware_video_acceleration

{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.hardware.videoAccel;
in
{
  options = {
    hardware.videoAccel = {
      enable = lib.mkEnableOption "videoAccel";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.opengl.enable = lib.mkForce true;
    hardware.opengl.extraPackages = with pkgs; [
      intel-media-driver
      libva
      libvdpau
    ];

    # explicitly states what driver to use
    environment.variables = {
      LIBVA_DRIVER_NAME = "iHD";
      VDPAU_DRIVER = "va_gl";
    };
  };
}
