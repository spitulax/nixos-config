{
  description = "A project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      eachSystem = f: lib.genAttrs systems f;
      pkgsFor = eachSystem (system:
        import nixpkgs {
          inherit system;
          overlays = [
            self.overlays.default
            rust-overlay.overlays.default
            (final: _: {
              rustPlatform = final.makeRustPlatform {
                cargo = self.rustToolchain.${final.system};
                rustc = self.rustToolchain.${final.system};
              };
            })
          ];
        });
    in
    {
      rustToolchain = eachSystem (system: pkgsFor.${system}.rust-bin.stable.latest.default);

      overlays = import ./nix/overlays.nix { inherit self lib inputs; };

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
            nativeBuildInputs = with pkgs; [
              self.rustToolchain.${system}
            ];
            shellHook = "exec $SHELL";
          };
        }
      );
    };
}
