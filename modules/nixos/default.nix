{ lib }: {
  # Optional features
  features = lib.genAttrsEachFilesExt ./features "nix" (n: import ./features/${n});

  # Global configs
  common = import ./common;
  desktop = import ./desktop;
  server = import ./server;
  laptop = import ./laptop;

  # Users
  users = lib.genAttrsEachFilesExt ./users "nix" (n: import ./users/${n});
}
