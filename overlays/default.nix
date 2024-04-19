{ inputs
, ...
}: {
  # Add custom packages
  # This is where packages from ../packages are added to pkgs
  add = final: _: import ../packages { pkgs = final; };

  # Modify packages from nixpkgs
  modify = final: prev: {
    # spotdl is supposed to use ffmpeg 4
    # https://github.com/spotDL/spotify-downloader/blob/v4.2.5/spotdl/utils/ffmpeg.py#L37
    spotdl = prev.spotdl.override { ffmpeg = final.ffmpeg_4; };

    keymapper = prev.keymapper.overrideAttrs rec {
      version = "4.0.2";
      src = final.fetchFromGitHub {
        owner = "houmain";
        repo = "keymapper";
        rev = version;
        hash = "sha256-a9CuLchSSfS4w3pZylzdiUr/llMsuU2qDR3mJrAupZk=";
      };
    };
  };
}
