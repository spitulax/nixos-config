{
  # Optional features
  gaming = import ./gaming.nix;
  keymapper = import ./keymapper.nix;
  video-hardware = import ./video-hardware.nix;

  # Global configs
  common = import ./common;
  desktop = import ./desktop;
  server = import ./server;

  # Users
  users = {
    bintang = import ./users/bintang.nix;
  };
}
