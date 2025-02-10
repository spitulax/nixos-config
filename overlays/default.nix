{ inputs
, lib
, myLib
, tempPkgsFor
, outputs
}: {
  # Add custom packages
  # This is where packages from ../packages are added to pkgs
  add = final: _: {
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
    mypkgs = builtins.removeAttrs inputs.mypkgs.packages.${final.system} [ "all" ];

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
  };

  # Modify packages from nixpkgs
  modify = final: prev: {
    # spotdl is supposed to use ffmpeg 4
    # otherwise downloading large albums will make it stuck
    # https://github.com/spotDL/spotify-downloader/blob/v4.2.5/spotdl/utils/ffmpeg.py#L37
    spotdl = prev.spotdl.override { ffmpeg = final.ffmpeg_4; };

    lutris = prev.lutris.override {
      steamSupport = false;
      extraPkgs = p: with p; [
        gamescope
        mangohud
        winetricks
      ];
    };

    inherit (final.mypkgs)
      hyprlock
      hyprpaper
      hyprpicker
      hyprpolkitagent
      hyprswitch
      waybar
      whitesur-cursors
      ;
  };

  # Compose existing overlays
  overlay =
    let
      overlays = with inputs;
        [
          rust-overlay.overlays.default
        ];
    in
    final: prev: prev.lib.composeManyExtensions overlays final prev;
}
