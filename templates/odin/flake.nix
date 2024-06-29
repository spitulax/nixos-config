{
  description = "An Odin project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    mypkgs.url = "github:spitulax/mypkgs";
  };

  outputs = { self, nixpkgs, mypkgs, ... }:
    let
      inherit (nixpkgs) lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      eachSystem = f: lib.genAttrs systems f;
      pkgsFor = eachSystem (system:
        import nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              inherit (mypkgs.packages.${final.system}) odin;
            })
          ];
        });
    in
    {
      devShells = eachSystem (system:
        let
          pkgs = pkgsFor.${ system};
        in
        {
          default = pkgs.mkShell {
            name = "foobar" + "-shell";
            nativeBuildInputs = with pkgs; [
              odin
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
