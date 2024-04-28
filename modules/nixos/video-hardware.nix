# Fixes the problem with hardware video acceleration not working in my laptop.
# Currently only works for Intel HD Graphics series Broadwell (2014) or newer.
# https://wiki.archlinux.org/title/Hardware_video_acceleration

{ pkgs
, lib
, ...
}: {
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
}
