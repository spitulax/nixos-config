{ self, lib, inputs }: {
  default = final: prev: rec {
    foobar = final.callPackage ./default.nix { };
    foobar-debug = foobar.override { debug = true; };
  };
}
