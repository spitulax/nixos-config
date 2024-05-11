{ inputs
, lib
}: {
  # Add custom packages
  # This is where packages from ../packages are added to pkgs
  add = final: _: {
    custom = import ../packages { inherit lib; pkgs = final; };
  };

  # Modify packages from nixpkgs
  modify = final: prev: {
    # spotdl is supposed to use ffmpeg 4
    # otherwise downloading large albums will make it stuck
    # https://github.com/spotDL/spotify-downloader/blob/v4.2.5/spotdl/utils/ffmpeg.py#L37
    spotdl = prev.spotdl.override { ffmpeg = final.ffmpeg_4; };

    mypkgs = builtins.removeAttrs inputs.mypkgs.packages.${final.system} [ "all" ];
  };
}
