{ inputs
, lib
, outputs
}: {
  # Add custom packages
  # This is where packages from ../packages are added to pkgs
  add = final: _: {
    custom = outputs.packages.${final.system};
    mypkgs = builtins.removeAttrs inputs.mypkgs.packages.${final.system} [ "all" ];
  };

  # Modify packages from nixpkgs
  modify = final: prev: {
    # spotdl is supposed to use ffmpeg 4
    # otherwise downloading large albums will make it stuck
    # https://github.com/spotDL/spotify-downloader/blob/v4.2.5/spotdl/utils/ffmpeg.py#L37
    spotdl =
      let
        pkgs = outputs.tempPkgsFor.spotdl.${final.system};
      in
      pkgs.spotdl.override { ffmpeg = pkgs.ffmpeg_4; };
  };

  # Compose existing overlays
  overlay =
    let
      overlays = with inputs; [
        emacs-overlay.overlays.default
      ];
    in
    final: prev: prev.lib.composeManyExtensions overlays final prev;
}
