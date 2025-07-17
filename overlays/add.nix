{ lib
, myLib
, outputs
, inputs
, ...
}: {
  preAdd = final: prev: { };

  # Add custom packages
  # This is where packages from ../packages are added to pkgs
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

    custom = outputs.packages.${final.system};

    # inputs.<flake>.packages|legacyPackages.<pkgs.system> -> pkgs.inputs.<flake>
    inputs =
      builtins.mapAttrs
        (
          _: flake:
            let
              legacyPackages = (flake.legacyPackages or { }).${final.system} or { };
              packages = (flake.packages or { }).${final.system} or { };
            in
            if legacyPackages != { }
            then legacyPackages
            else packages
        )
        inputs;

    # Helper functions
    makeUnitScript = name: text:
      final.writeShellScriptBin "unit-script-${name}" ''
        set -e
        ${text}
      '';

    # KDE "channel"
    kde = final.libsForQt5;

    inherit (final.mypkgs)
      hyprlock
      hyprpaper
      hyprpicker
      hyprpolkitagent
      waybar
      whitesur-cursors
      gplates
      ;
  };

  postAdd = final: prev: { };
}

