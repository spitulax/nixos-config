{ lib
, myLib
, inputs
, pkgsFor
, specialArgs
, users
, ...
}: {
  # NixOS configs
  nixosConfigurations = {
    # Personal laptop
    "barbatos" = myLib.nixosConfig {
      hostName = "barbatos";
      config = ../hosts/barbatos;
      users = with users; [ bintang ];
      pkgs = pkgsFor.x86_64-linux;
    };
  };

  # Android on termux
  nixOnDroidConfigurations.default = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
    modules = [ ../hosts/dantalion ];
    pkgs = lib.mergeAttrsConcatenateValues pkgsFor.aarch64-linux {
      overlays = [
        inputs.nix-on-droid.overlays.default
      ];
    };
    extraSpecialArgs = specialArgs;
  };
  nixOnDroidHomeConfigurations.default = ../users/bintang_dantalion;

  # Home configs
  homeConfigurations = {
    # Personal laptop
    "bintang@barbatos" = myLib.homeManagerConfig {
      config = ../users/bintang_barbatos;
      pkgs = pkgsFor.x86_64-linux;
    };
  };
}
