{ inputs
, lib
, outputs
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
  };

  # Modify packages from nixpkgs
  modify = final: prev: {
    # spotdl is supposed to use ffmpeg 4
    # otherwise downloading large albums will make it stuck
    # https://github.com/spotDL/spotify-downloader/blob/v4.2.5/spotdl/utils/ffmpeg.py#L37
    spotdl = prev.spotdl.override { ffmpeg = final.ffmpeg_4; };
  };

  # Compose existing overlays
  overlay =
    let
      overlays = with inputs; [ ];
    in
    final: prev: prev.lib.composeManyExtensions overlays final prev;
}
