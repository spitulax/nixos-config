{ myLib }: {
  # Optional features
  features = myLib.genAttrsEachFilesExt ./features "nix" (n: import ./features/${n});

  # Global configs
  common = import ./common;
  desktop = import ./desktop;
  server = import ./server;
  laptop = import ./laptop;

  # Users
  users = myLib.genAttrsEachFilesExt ./users "nix" (n: import ./users/${n});
}
