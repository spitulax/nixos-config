{ inputs
, ...
}: {
  # Add custom packages
  # This is where packages from ../packages are added to pkgs
  add = final: _: import ../packages { pkgs = final; };

  # Modify packages from nixpkgs
  modify = final: prev: {
    brave = prev.brave.override {
      libvaSupport = true;
      enableVideoAcceleration = true;
    };

    steam = prev.steam.override {
      extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${final.inputs.nix-gaming.proton-ge}'";
    };

    # ffmpeg 6 won't work, spotdl will stuck at converting
    spotdl = prev.spotdl.override { ffmpeg = final.ffmpeg_4; };

    # TODO: upstream this
    keymapper = prev.keymapper.overrideAttrs (newAttrs: oldAttrs: {
      version = "3.5.3";
      src = final.fetchFromGitHub {
        owner = "houmain";
        repo = "keymapper";
        rev = newAttrs.version;
        hash = "sha256-CfZdLeWgeNwy9tEJ3UDRplV0sRcKE4J6d3CxC9gqdmE=";
      };
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ final.libxkbcommon ];
    });
  };

  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs
      (_: flake:
        let
          legacyPackages = (flake.legacyPackages or { }).${final.system} or { };
          packages = (flake.packages or { }).${final.system} or { };
        in
        if legacyPackages != { } then legacyPackages else packages
      )
      inputs;
  };
}
