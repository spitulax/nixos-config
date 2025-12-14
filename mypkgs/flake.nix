{
  description = "My Nix packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # TODO: This solution is a hack before we can override inputs with `builtins.getFlake`

    crt = {
      url = "github:spitulax/crt";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gripper = {
      url = "github:spitulax/gripper";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pasteme = {
      url = "github:spitulax/pasteme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;
      myLib = import ./lib { inherit lib; };

      systems = [ "x86_64-linux" "aarch64-linux" ];
      eachSystem = f: lib.genAttrs systems f;
      foreachSystem = f: lib.genAttrs systems f;

      pkgsFor = foreachSystem (system:
        import nixpkgs {
          inherit system;
          config.allowUnfreePredicate = p:
            builtins.elem (lib.getName p) [
              "osu-lazer"
            ];
        });
      utilsFor = foreachSystem
        (system:
          pkgsFor.${system}.callPackage ./utils { inherit myLib outputs inputs; }
        );

      packagesFor = foreachSystem
        (system:
          import ./pkgs {
            inherit myLib;
            pkgs = pkgsFor.${system};
            utils = utilsFor.${system};
          }
        );
      flakesFor = foreachSystem
        (system:
          import ./flakes {
            inherit myLib;
            pkgs = pkgsFor.${system};
            utils = utilsFor.${system};
          }
        );
    in
    {
      flakes = lib.mapAttrs (_: v: v.flakes) flakesFor;

      overlays = {
        default = self.overlays.mypkgs;
        mypkgs = final: _: {
          mypkgs = packagesFor.${final.system}.packages;
        };
        mypkgsOverride = _: prev:
          packagesFor.${prev.system}.packages;
      };

      packages = eachSystem
        (system:
          let
            pkgs = pkgsFor.${system};
            packages = packagesFor.${system};
            flakes = flakesFor.${system};
            cachedPackages = myLib.drv.cached packages.packages;
          in
          packages.packages
          // {
            # This packages are exposed to `packages` output for convenience.
            # Use the overlay for accessing packages.

            # `cached` is built by the helper "script" for its result to be pushed to cachix.
            cached = pkgs.linkFarm "mypkgs-cached" cachedPackages;
            # `*-update-scripts` is run by the helper "script" and will modify the repo tree.
            pkgs-update-scripts = packages.update-scripts;
            flakes-update-scripts = flakes.update-scripts;

            # Lists packages in a form of a Markdown table for documentation.
            mypkgs-list = pkgs.callPackage myLib.helpers.pkgsListTable {
              inherit (packages) packages;
              inherit (flakes) flakes;
            };
            # The helper "script". Where everything needed is there.
            helper = pkgs.callPackage myLib.helpers.helper { };
          }
        );

      # For testing
      inherit myLib utilsFor packagesFor flakesFor pkgsFor;
    };
}
