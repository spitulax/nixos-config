{
  # Optional features
  gaming = import ./gaming.nix;
  keymapper = import ./keymapper.nix;
  video-hardware = import ./video-hardware.nix;
  vm = import ./vm.nix;
  plasma = import ./plasma.nix;
  zram = import ./zram.nix;

  # Global configs
  common = import ./common;
  desktop = import ./desktop;
  server = import ./server;
  laptop = import ./laptop.nix;

  # Users
  users = {
    bintang = import ./users/bintang.nix;
  };
}
