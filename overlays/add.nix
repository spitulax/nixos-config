{ lib
, myLib
, inputs
, tempPkgsFor
, ...
}: {
  preAdd = final: prev: { };

  # Add custom packages
  addPhase = final: prev: {
    # Custom `callPackage`
    myCallPackage =
      (lib.makeScope lib.callPackageWith
        (self: {
          pkgs = final;
          inherit myLib lib;
          inherit (self) callPackage;
          inherit (final) system;
        } // final)).callPackage;

    # inputs.<flake>.packages|legacyPackages.<pkgs.system> or inputs.<flake> -> pkgs.inputs.<flake>
    inputs =
      builtins.mapAttrs
        (_: flake:
          let
            legacyPackages = (flake.legacyPackages or { }).${final.system} or { };
            packages = (flake.packages or { }).${final.system} or { };
            self = flake;
          in
          if packages != { }
          then packages
          else if legacyPackages != { }
          then legacyPackages
          else self
        )
        inputs;

    tempPkgs =
      builtins.mapAttrs
        (_: pkgs: pkgs.${final.system})
        tempPkgsFor;

    # Helper functions
    makeUnitScript = name: text:
      final.writeShellScriptBin "unit-script-${name}" ''
        set -e
        ${text}
      '';

    # KDE "channel"
    kde = final.kdePackages;

    inherit (final.mypkgs)
      whitesur-cursors
      gplates
      osu-lazer
      rose-pine-tmux
      ;
  };

  postAdd = final: prev: { };
}

