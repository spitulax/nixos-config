{ inputs
, ...
}: {
  # Add custom packages
  # This is where packages from ../packages are added to pkgs
  add = final: _: import ../packages { pkgs = final; };

  # Modify packages from nixpkgs
  modify = final: prev: {
    # spotdl is supposed to use ffmpeg 4
    # otherwise downloading large albums will make it stuck
    # https://github.com/spotDL/spotify-downloader/blob/v4.2.5/spotdl/utils/ffmpeg.py#L37
    spotdl = prev.spotdl.override { ffmpeg = final.ffmpeg_4; };

    keymapper = prev.keymapper.overrideAttrs (newAttrs: oldAttrs: {
      version = "4.1.3";
      src = final.fetchFromGitHub {
        owner = "houmain";
        repo = "keymapper";
        rev = newAttrs.version;
        hash = "sha256-hzqZ8rr1qK++oUL+ZOiYLLmrN79SDcUYBFaepOUMu4s=";
      };
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ (with final; [
        gtk3
        libappindicator
      ]);
    });
  };
}
