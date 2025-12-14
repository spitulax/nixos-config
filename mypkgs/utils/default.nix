{ lib
, myLib
, inputs
, outputs
, pkgs
, curl
, jq
, writeShellScript
, fetchFromGitHub
, nix
, coreutils
, fetchzip
, runCommand
, gnused
, fetchurl
, callPackage
, gnutar
, unzip
}:
let
  inherit (builtins)
    toString
    ;

  inherit (lib)
    getExe
    replaceStrings
    toShellVar
    ;

  inherit (myLib)
    shell
    getPkgData
    getFlakeData
    ;

  ghApi = callPackage shell.ghApi { };
  serialiseJSON = callPackage shell.serialiseJSON { };
  importJSON = callPackage shell.importJSON { };
  getFileHash = callPackage shell.getFileHash { };
in
rec {
  /*
    Functions that create a derivation extracted from an archive file.

    Inputs:
      - `src`: The archive

    Type: AttrSet -> Derivation
  */
  archiveTools = {
    # `flatten` can only be used if the archive only contains one folder at top-level

    extractTarGz = { src, flatten ? false, ... }@args:
      runCommand
        "source"
        ({
          nativeBuildInputs = [ gnutar ];
          outputs = [ "out" ];
        } // args)
        (''
          mkdir -p $out
          tar xf $src --directory=$out
        '' + lib.optionalString flatten ''
          DIR="$out/$(ls $out)"
          mv "$DIR"/* $out
          rmdir "$DIR"
        '');

    extractZip = { src, flatten ? false, ... }@args:
      runCommand
        "source"
        ({
          nativeBuildInputs = [ unzip ];
          outputs = [ "out" ];
        } // args)
        (''
          mkdir -p $out
          unzip $src -d $out
        '' + lib.optionalString flatten ''
          DIR="$out/$(ls $out)"
          mv "$DIR"/* $out
          rmdir "$DIR"
        '');
  };

  /*
    Returns a flake from `/flakes`.

    Inputs:
      - `name`: The flake name as defined in `/flakes/list.nix`

    Type: String -> Flake
  */
  getFlake = name:
    outputs.flakes.${pkgs.system}.${name}.flake;

  /*
    Returns a package provided by a flake.

    Inputs:
      - `flake`: The flake
      - `name`: The package name

    Type: Flake -> String -> Derivation
  */
  getFlakePackage = flake: name:
    flake.packages.${pkgs.system}.${name};

  /*
    Returns a package provided by a flake.

    Inputs:
      - `flake`: The flake name name as defined in `/flakes/list.nix`
      - `name`: The package name

    Type: String -> String -> Derivation
  */
  getFlakePackage' = flakeName: pkgName:
    (getFlake flakeName).packages.${pkgs.system}.${pkgName};

  /*
    Returns packages provided by a flake.

    Inputs:
      - `flake`: The flake

    Type: Flake -> AttrSet
  */
  getFlakePackages = flake:
    flake.packages.${pkgs.system};

  /*
    Returns packages provided by a flake.

    Inputs:
      - `flake`: The flake name name as defined in `/flakes/list.nix`
      - `name`: The package name

    Type: String -> AttrSet
  */
  getFlakePackages' = flakeName:
    (getFlake flakeName).packages.${pkgs.system};

  /*
    Notes about *VersionScript functions:
    - Return a shell script.
    - Should only be called from `/flakes` or `/pkgs` but not enforced.
    - Should accept the previous `orig_version` (for *Pkg) or `rev` (for *Flake) as an
      argument ($1) from the helper "script" and add the check with
      `exitIfNoNewVer` to the script. The argument may be an empty string.
    - If it does call to `exitIfNoNewVer`, output `orig_version` just to indicate the version script
      caller to propagate `orig_version`.
    - The argument to pass to `exitIfNoNewVer` is the same as the one outputted to `orig_version`.
    - Any custom update script that doesn't call *VersionScript must also add `exitIfNoNewVer` themselves.
  */

  /*
    See Notes about *VersionScript functions.

    Type: String -> String
  */
  exitIfNoNewVer = ver: ''
    if [ "$FORCE" -ne 1 ] && [ -n "$1" ]; then
      [ "${ver}" == "$1" ] && exit 200
    fi
  '';

  /*
    A script that fetches the latest commit in a branch/tag or release from a GitHub repository.
    See Notes about *VersionScript functions.

    JSON output:
      {
        rev: The Git commit hash
        version:
          The version will be generated based on the branch name and commit hash if `ref` is not empty
          Otherwise it will be taken from the release name with the initial non-number characters removed
        release_name: The release name unaltered. Empty if `ref` is not empty
        orig_version: Propagate this.
      }

    Type: AttrSet -> Derivation
  */
  gitHubVersionScript =
    { owner
    , repo
    , ref ? ""        # The branch or tag name. Empty means fetch latest release
    , dirname ? repo  # For identification only
    }:
    let
      updateScript = writeShellScript "mypkgs-update-version-${dirname}" ''
        set -euo pipefail

        ${toShellVar "CURL" (getExe curl)}
        ${toShellVar "SED" (getExe gnused)}
        ${toShellVar "DATE" "${coreutils}/bin/date"}
        ${toShellVar "HEAD" "${coreutils}/bin/head"}

        if [ -z "${ref}" ]; then
          RELEASE_INFO=${ghApi "/repos/${owner}/${repo}/releases/latest"}
          TAG=${importJSON "$RELEASE_INFO" ".tag_name"}
          TAG_INFO=${ghApi "/repos/${owner}/${repo}/git/ref/tags/$TAG"}
          TYPE=${importJSON "$TAG_INFO" ".object.type"}
          TAG_SHA=${importJSON "$TAG_INFO" ".object.sha"}
          if [ "$TYPE" == "commit" ]; then
            REV="$TAG_SHA"
          else
            REV=${importJSON (ghApi "/repos/${owner}/${repo}/git/tags/$TAG_SHA") ".object.sha"}
          fi
          RELEASE_NAME=${importJSON "$RELEASE_INFO" ".name"}
          VERSION=$(echo "$RELEASE_NAME" | $SED 's/[^0-9]*//')
          ORIG_VERSION="$RELEASE_NAME"
        else
          COMMIT=${ghApi "/repos/${owner}/${repo}/commits/${ref}"}
          REV=${importJSON "$COMMIT" ".sha"}
          COMMIT_DATE=${importJSON "$COMMIT" ".commit.committer.date"}
          DATE=$($DATE -d "$COMMIT_DATE" --utc '+%Y-%m-%d')
          VERSION=$(printf '%s+ref=%s_%s' "$DATE" "${ref}" "$(echo "$REV" | "$HEAD" -c7)")
          ORIG_VERSION="$REV"
        fi

        ${exitIfNoNewVer "$ORIG_VERSION"}

        ${serialiseJSON {
          rev = "$REV";
          version = "$VERSION";
          release_name = "\${RELEASE_NAME:-}";
          orig_version = "$ORIG_VERSION";
        }}
      '';
    in
    updateScript;

  /*
    A script that fetches the hash of a file from a url.
    See Notes about *VersionScript functions.

    JSON output:
      {
        url: The url to the file
        hash: The hash of the file
      }

    Type: AttrSet -> Derivation
  */
  urlScript =
    { url
    , dirname # For identification only
    , archive ? false # Is the file an archive (set it accordingly or you will get mismatched hashes)
    , executable ? false # Is the file an executable
    }:
    let
      updateScript = writeShellScript "mypkgs-update-archive-${dirname}" ''
        set -euo pipefail

        URL="${url}"
        HASH=${getFileHash {url = "$URL"; inherit executable archive;}}

        ${serialiseJSON {
          url = "$URL";
          hash = "$HASH";
        }}
      '';
    in
    updateScript;

  /*
    Notes about *Pkg functions (except mkPkg):
    - Return a `MypkgsPkg` by calling `mkPkg`. See `mkPkg`.
    - Only expected to be used from somewhere within `/pkgs` or it will not work.
    - Generate `pkg.json` in the given `dirname` through the helper "script".
    - `updateScript` should accept the previous version as an argument ($1) from
      the helper "script".
      When calling *VersionScript, it should also pass the argument.
    - Storing `orig_version` in `pkg.json` is necessary.
      orig_version:
        The version as it was fetched with *VersionScript
        This is important for `exitIfNoNewVer` to work since this data is passed
        to the update script every execution to be compared with newly found
        version and so must have the same format
        Not used for storing derivation version, use `version` instead

    MypkgsPkg :: AttrSet {
      version :: String: The package version
      src :: Derivation: The fetched source
      passthru :: AttrSet {
        dirname :: String: The directory of the package declaration relative to `/pkgs`
        updateScript :: Derivation: The update script (run from the helper "script")
      }
    }
  */
  # MAYBE: Add preUpdateScripts or postUpdateScripts

  /*
    Returns an attribute set that could be used to override a derivation to
    give it necessary attribute for this repo.
    See Notes about *Pkg functions (except mkPkg).

    Type: AttrSet -> MypkgsPkg
  */
  mkPkg =
    { version
    , src
    , updateScript
    , dirname
    }: {
      inherit version src;
      passthru = {
        inherit dirname;
        mypkgsUpdateScript = updateScript;
      };
    };

  /*
    Returns a `MypkgsPkg` fetched from a GitHub source from the latest release
    or commit in a branch/tag.
    See Notes about *Pkg functions.
    See also `gitHubVersionScript`.

    JSON output:
      {
        hash: The source's hash
        rev: The commit hash
        version: The generated version
          The version will be generated based on the branch name and commit hash if `ref` is not empty
          Otherwise it will be taken from the release name with the initial non-number characters removed
        orig_version: Propagated from `GitHubVersionScript`
      }

    Type: AttrSet -> MypkgsPkg
  */
  gitHubPkg =
    { owner
    , repo
    , ref ? ""        # The branch or tag name. Empty means fetch latest release
    , dirname ? repo
    }@inputs:
    let
      pkgData = getPkgData dirname;
      versionScript = gitHubVersionScript inputs;

      src = fetchFromGitHub {
        inherit owner repo;
        inherit (pkgData) hash rev;
      };

      updateScript = writeShellScript "mypkgs-update-github-${dirname}" ''
        set -euo pipefail

        VERSIONDATA=$(${versionScript} "$1")
        REV=${importJSON "$VERSIONDATA" ".rev"}
        VERSION=${importJSON "$VERSIONDATA" ".version"}
        ORIG_VERSION=${importJSON "$VERSIONDATA" ".orig_version"}
        HASH=${getFileHash {url = "https://github.com/${owner}/${repo}/archive/\${REV}.tar.gz"; archive = true;}}

        ${serialiseJSON {
          hash = "$HASH";
          rev = "$REV";
          version = "$VERSION";
          orig_version = "$ORIG_VERSION";
        }}
      '';
    in
    mkPkg {
      inherit (pkgData) version;
      inherit src updateScript dirname;
    };

  /*
    Returns a `MypkgsPkg` fetched from an asset of the latest GitHub release.
    See Notes about *Pkg functions.

    JSON output:
      {
        url: The url to the asset
        version: The version taken from the release name
          (adjust with `prefixVersion` and `useReleaseName`)
        orig_version: Propagated from `gitHubVersionScript`
        hash: The asset's hash
      }

    Type: AttrSet -> MypkgsPkg
  */
  gitHubReleasePkg =
    { owner
    , repo
      # "%v" will be replaced by the version (without any non-digit prefix)
      # "%V" will be replaced by the release name
    , assetName
    , dirname ? repo
    , prefixVersion ? false   # Prefix the version with "0."
    , useReleaseName ? false  # Use the full release name for the version
    }:
    let
      pkgData = getPkgData dirname;
      versionScript = gitHubVersionScript {
        inherit owner repo dirname;
      };
      inherit (pkgData) version;

      shAssetName = replaceStrings [ "%V" "%v" ] [ "\${1}" "\${2}" ] assetName;
      archive = myLib.isArchive assetName;
      hashScript = urlScript {
        inherit dirname archive;
        url = "https://github.com/${owner}/${repo}/releases/download/\${1}/${shAssetName}";
      };

      src =
        if archive
        then
          (fetchzip {
            inherit (pkgData) hash url;
          })
        else
          (fetchurl {
            inherit (pkgData) hash url;
          });

      updateScript = writeShellScript "mypkgs-update-githubrelease-${dirname}" ''
        set -euo pipefail

        VERSIONDATA=$(${versionScript} "$1")
        VERSION=${importJSON "$VERSIONDATA" ".version"}
        ORIG_VERSION=${importJSON "$VERSIONDATA" ".orig_version"}
        RELEASE_NAME=${importJSON "$VERSIONDATA" ".release_name"}
        ARCHIVEDATA=$(${hashScript} "$RELEASE_NAME" "$VERSION")
        HASH=${importJSON "$ARCHIVEDATA" ".hash"}
        URL=${importJSON "$ARCHIVEDATA" ".url"}

        if [ '${toString useReleaseName}' == "1" ]; then
          VERSION="$RELEASE_NAME"
        fi
        if [ '${toString prefixVersion}' == "1" ]; then
          VERSION="0.$VERSION"
        fi

        ${serialiseJSON {
          url = "$URL";
          version = "$VERSION";
          orig_version = "$ORIG_VERSION";
          hash = "$HASH";
        }}
      '';
    in
    mkPkg {
      inherit updateScript dirname src version;
    };

  /*
    Notes about *Flake functions (except mkFlake):
    - Return a `MypkgsFlake` by calling `mkFlake`. See `mkFlake`.
    - Only expected to be used from somewhere within `/flakes` or it will not work.
    - Generate `flake.json` in the given `dirname` through the helper "script".
    - `updateScript` should accept the previous commit hash as an argument ($1) from
      the helper "script".
      When calling *VersionScript, it should also pass the argument.
    - Storing `rev` in `flake.json` is necessary.

    MypkgsFlake :: AttrSet {
      rev :: String: The flake's commit hash
      flake :: Flake: The actual Nix flake object
        (nested to avoid evaluating it before the `flake.json` is generated)
      dirname :: String: The directory of the package declaration relative to `/flakes`
      updateScript :: Derivation: The update script (run from the helper "script")
      homepage :: String: Equivalent to `meta.homepage`
    }
  */

  /*
    Returns an attribute set that could be used to fetch and access a flake.
    See Notes about *Flake functions (except mkFlake).

    Type: AttrSet -> MypkgsFlake
  */
  mkFlake =
    { updateScript
    , flake
    , rev
    , dirname
    , homepage
    }: {
      inherit rev updateScript dirname flake homepage;
    };

  /*
    Returns a `MypkgsFlake` fetched from a GitHub source from the latest
    release or commit in a branch/tag.
    See Notes about *Flake functions.
    See also `gitHubVersionScript`.

    JSON output:
      {
        rev: The commit hash
      }

    Type: AttrSet -> MypkgsPkg
  */
  gitHubFlake =
    { owner
    , repo
    , ref ? "" # empty means fetch latest release
    , dirname ? repo
    , submodules ? false
    }:
    let
      versionScript = gitHubVersionScript {
        inherit owner repo ref dirname;
      };

      inherit (getFlakeData dirname) rev;
      # TODO: https://github.com/NixOS/nix/pull/11952 overrideable inputs
      url =
        if submodules
        then "git+https://github.com/${owner}/${repo}?rev=${rev}&submodules=1"
        else "github:${owner}/${repo}?rev=${rev}";
      flake = builtins.getFlake url;

      homepage = "https://github.com/${owner}/${repo}";

      updateScript = writeShellScript "mypkgs-update-githubflake-${dirname}" ''
        set -euo pipefail

        VERSIONDATA=$(${versionScript} "$1")
        REV=${importJSON "$VERSIONDATA" ".rev"}
        ${exitIfNoNewVer "$REV"}

        ${serialiseJSON {
          rev = "$REV";
        }}
      '';
    in
    mkFlake {
      inherit updateScript dirname flake rev homepage;
    };

  /*
    Returns a `MypkgsFlake` from this flake's inputs.
    Add the desired flake into this flake's inputs in `/flake.nix`
    and then reference the flake here.
    See Notes about *Flake functions.

    Does not output a JSON file.

    Type: AttrSet -> MypkgsPkg
  */
  nixFlake =
    { name # The flake's name as defined in this flake's inputs
    , homepage # Equivalent to `meta.homepage`
    , dirname ? name
    }:
    let
      flake = inputs.${name};
    in
    mkFlake {
      inherit dirname homepage flake;
      inherit (flake) rev;
      updateScript = null;
    };
}
