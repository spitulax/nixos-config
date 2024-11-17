{ inputs
, lib
, outputs
, tempPkgsFor
}: {
  # Add custom packages
  # This is where packages from ../packages are added to pkgs
  add = final: _: {
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

    # Nerdfonts
    iosevka-nerdfont = final.nerdfonts.override { fonts = [ "Iosevka" ]; };
    nerdfonts-symbols-only = final.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; };

    # Helper functions
    makeUnitScript = name: text:
      final.writeShellScriptBin "unit-script-${name}" ''
        set -e
        ${text}
      '';
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

    inherit (final.mypkgs) hyprlock hyprpaper hyprpicker hyprpolkitagent waybar;

    inherit (tempPkgsFor.cava.${final.system}) cava;
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
