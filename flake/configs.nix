{ lib
, inputs
, pkgsFor
, specialArgs
}: {
  # NixOS configs
  nixosConfigurations = {
    # Personal laptop
    "barbatos" = lib.nixosSystem {
      modules = [ ../hosts/barbatos ];
      inherit specialArgs;
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
    "bintang@barbatos" = lib.homeManagerConfiguration {
      pkgs = pkgsFor.x86_64-linux;
      modules = [ ../users/bintang_barbatos ];
      extraSpecialArgs = specialArgs;
    };
  };
}
