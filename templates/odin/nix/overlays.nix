{ self, lib, inputs, mypkgs }: {
  default = final: prev: rec {
    foobar = final.callPackage ./default.nix { };
    foobar-debug = foobar.override { debug = true; };
  };

  odin = final: prev: {
    odin = mypkgs.packages.${final.system}.odin;
  };
}
