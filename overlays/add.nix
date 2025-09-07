{ lib
, myLib
, outputs
, inputs
, tempPkgsFor
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
        (_: flake:
          let
            legacyPackages = (flake.legacyPackages or { }).${final.system} or { };
            packages = (flake.packages or { }).${final.system} or { };
          in
          if packages != { }
          then packages
          else legacyPackages)
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
      # hyprlock
      # hyprpaper
      # hyprpicker
      # hyprpolkitagent
      waybar
      whitesur-cursors
      gplates
      osu-lazer
      rose-pine-tmux
      ;

    # TEMP: These are here until I can override flakes in mypkgs
    hyprlock = final.inputs.hyprlock.hyprlock;
    hyprpaper = final.inputs.hyprpaper.hyprpaper;
    hyprpicker = final.inputs.hyprpicker.hyprpicker;
    hyprpolkitagent = final.inputs.hyprpolkitagent.hyprpolkitagent;
  };

  postAdd = final: prev: { };
}

