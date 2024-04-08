{
  description = "A C/C++ project";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system} system);
    in
    {
      packages = forEachSystem (pkgs: system: {
        default = with pkgs; stdenv.mkDerivation {
          pname = "foobar";
          version = "0.1.0";
          src = ./.;

          nativeBuildInputs = [

          ];

          buildInputs = [

          ];

          makeFlags = [ "PREFIX=$(out)" ];
        };
      });

      devShells = forEachSystem (pkgs: system:
        builtins.mapAttrs
          (_: p:
            p.overrideAttrs (finalAttrs: prevAttrs: with pkgs; {
              nativeBuildInputs = [
                hello
              ] ++ (prevAttrs.nativeBuildInputs or [ ]);
              CPATH = lib.makeSearchPathOutput "dev" "include" finalAttrs.buildInputs;
            })
          )
          self.packages.${system}
      );
    };
}
