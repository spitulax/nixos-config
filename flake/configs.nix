{ myLib
, pkgsFor
, users
, ...
}: {
  # NixOS configs
  nixosConfigurations = {
    # Personal laptop
    "barbatos" = myLib.nixosConfig {
      hostname = "barbatos";
      users = with users; [ bintang ];
      pkgs = pkgsFor.x86_64-linux;
    };
  };

  # Home configs
  homeConfigurations = {
    # Personal laptop
    "bintang@barbatos" = myLib.homeManagerConfig {
      username = "bintang";
      hostname = "barbatos";
      pkgs = pkgsFor.x86_64-linux;
    };
  };
}
