{
  description = "An Odin project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    mypkgs.url = "github:spitulax/mypkgs";
  };

  outputs = { self, nixpkgs, mypkgs, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      eachSystem = f: lib.genAttrs systems f;
      pkgsFor = eachSystem (system:
        import nixpkgs {
          inherit system;
          overlays = [
            self.overlays.odin
            self.overlays.default
          ];
        });
    in
    {
      overlays = import ./nix/overlays.nix { inherit self lib inputs mypkgs; };

      packages = eachSystem (system:
        let
          pkgs = pkgsFor.${system};
        in
        {
          default = self.packages.${system}.foobar;
          inherit (pkgs) foobar foobar-debug;
        });

      devShells = eachSystem (system:
        let
          pkgs = pkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            name = lib.getName self.packages.${system}.default + "-shell";
            inputsFrom = [
              self.packages.${system}.default
            ];
            shellHook = "exec $SHELL";
          };
        }
      );
    };

  nixConfig = {
    extra-substituters = [
      "spitulax.cachix.org"
    ];
    extra-trusted-public-keys = [
      "spitulax.cachix.org-1:GQRdtUgc9vwHTkfukneFHFXLPOo0G/2lj2nRw66ENmU="
    ];
  };
}
