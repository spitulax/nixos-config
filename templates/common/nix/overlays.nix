{ self, lib, inputs }: {
  default = final: prev: {
    foobar = final.callPackage ./default.nix { };
  };
}
