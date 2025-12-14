{ lib }:
let
  inherit (builtins)
    toJSON
    ;

  inherit (lib)
    filterAttrs
    getExe
    concatStringsSep
    escape
    foldr
    hasSuffix
    optionalString
    concatMapAttrsStringSep
    ;
  inherit (lib.path)
    append
    ;

  # Type: String -> Path
  getPkgDataPath = dirname: append ./../pkgs (dirname + "/pkg.json");
  getFlakeDataPath = dirname: append ./../flakes (dirname + "/flake.json");
in
rec {
  /*
    Returns the content of `pkg.json` from a directory `dirname` in `/pkgs`.

    Inputs:
      - `dirname`: The directory's name

    Type: String -> AttrSet
  */
  getPkgData = dirname: lib.trivial.importJSON (getPkgDataPath dirname);
  getFlakeData = dirname: lib.trivial.importJSON (getFlakeDataPath dirname);

  /*
    Determines if a file is an archive file based on its extension.
    Prefetch-url `--unpack` flag can unpack zip and tar along with all supported filters from libarchive.
    <https://github.com/NixOS/nix/blob/3f3feae33e3381a2ea5928febe03329f0a578b20/src/libutil/tarfile.cc#L109>
    <https://github.com/libarchive/libarchive/blob/819a50a0436531276e388fc97eb0b1b61d2134a3/libarchive/archive_read_support_filter_all.c#L41>

    Inputs:
      - `name`: The file's name

    Type: String -> Bool
  */
  isArchive = name:
    foldr (a: b: hasSuffix a name || b) false [
      ".zip"
      ".tar"
      ".tar.bz2"
      ".tar.gz"
      ".tgz"
      ".tar.lz"
      ".tlz"
      ".tar.lz4"
      ".tar.lzma"
      ".tar.xz"
      ".txz"
      ".tar.Z"
      ".tar.lzo"
      ".tar.zst"
    ];

  /*
    Returns a date with `YYYY-MM-DD` format from `YYYYMMDD` format date string.

    Inputs:
      - `longDate`: `YYYYMMDD` date string.

    Type: String -> String
  */
  mkDate = longDate: (lib.concatStringsSep "-" [
    (builtins.substring 0 4 longDate)
    (builtins.substring 4 2 longDate)
    (builtins.substring 6 2 longDate)
  ]);

  /*
    Disambiguate versions by adding revision hash from a flake.

    Inputs:
      - `flake`: The flake object.
      - `version`: The version.

    Type: String -> String
  */
  mkLongVersion = flake: version:
    version
    + "+date=" + (mkDate (flake.lastModifiedDate or "19700101"))
    + "_" + (flake.shortRev or "dirty");

  drv = rec {
    /*
      Determines if a package is considered to be cached.
      Cached packages will be pushed to cachix.

      Inputs:
        - `d`: The package

      Type: AttrSet -> Bool
    */
    isCached = d: !(d ? _notCached && d._notCached);

    /*
      Gets packages that are cached or not from a set of packages.
      See `isCached`.

      Inputs:
        - `ds`: Attribute set of packages

      Type: AttrSet -> AttrSet
    */
    uncached = ds: filterAttrs (_: v: !isCached v) ds;
    cached = ds: filterAttrs (_: isCached) ds;

    /*
      Determines if a package or flake is considered to be maintained.
      Maintained packages or flakes will be automatically updated by the helper "script".

      Inputs:
        - `d`: The package or flake

      Type: AttrSet -> Bool
    */
    isMaintained = d: !(d ? _notMaintained && d._notMaintained);

    /*
      Gets packages or flakes that are maintained or not from a set of packages or flakes.
      See `isMaintained`.

      Inputs:
        - `ds`: Attribute set of packages or flakes

      Type: AttrSet -> AttrSet
    */
    unmaintained = ds: filterAttrs (_: v: !isMaintained v) ds;
    maintained = ds: filterAttrs (_: isMaintained) ds;

    /*
      Mark a package as not cached.
      See `isCached`.

      Inputs:
        - `d`: The package

      Type: AttrSet -> AttrSet
    */
    uncache = d: d // { _notCached = true; };

    /*
      Mark a package or flake as not maintained.
      See `isMaintained`.

      Inputs:
        - `d`: The package or flake

      Type: AttrSet -> AttrSet
    */
    unmaintain = d: d // { _notMaintained = true; };

    /*
      Mark a package as both not maintained and not cached.
      See `isCached` and `isMaintained`.

      Inputs:
        - `d`: The package

      Type: AttrSet -> AttrSet
    */
    ignore = d: d // { _notCached = true; _notMaintained = true; };
  };

  helpers = {
    /*
      mypkgs helper "script" derivation.

      Type: AttrSet -> Derivation
    */
    helper =
      { buildGoModule }:
      buildGoModule {
        pname = "helper";
        version = lib.trim (builtins.readFile ../helper/VERSION);

        src = lib.cleanSource ../helper;

        vendorHash = null;

        meta = {
          description = "Helper \"script\" for mypkgs";
          homepage = "https://github.com/spitulax/mypkgs";
          platforms = lib.platforms.all;
          license = lib.licenses.mit;
          maintainers = with lib.maintainers; [ spitulax ];
        };
      };

    /*
      Generates a derivation that writes a markdown file listing the packages and flakes
      for documentation purpose of this flake.

      Type: AttrSet -> Derivation
    */
    pkgsListTable =
      { lib
      , writeText
      , packages ? { }
      , flakes ? { }
      }:
      let
        yesNo = bool: if bool then "Yes" else "No";

        # TODO: Not recursive
        # Cannot handle packages/flakes nested inside an attrset
        pkgsList =
          ''
            | **Name** | **Version** | **Cached** | **Maintained** | **Homepage** |
            | :-: | :-: | :-: | :-: | :-: |
          ''
          + concatMapAttrsStringSep "\n"
            (k: v:
              "| **${k}** " +
              "| ${v.version} " +
              "| ${yesNo (drv.isCached v)} " +
              "| ${yesNo (drv.isMaintained v)} " +
              "| [🌐](${v.meta.homepage}) |"
            )
            packages;

        flakesList =
          ''
            | **Name** | **Rev** | **Maintained** | **Homepage** |
            | :-: | :-: | :-: | :-: |
          ''
          + concatMapAttrsStringSep "\n"
            (k: v:
              "| **${k}** " +
              "| ${v.rev} " +
              "| ${yesNo (drv.isMaintained v)} " +
              "| [🌐](${v.homepage}) |"
            )
            flakes;
      in
      writeText "mypkgs-list" ''
        <!--- This list was auto-generated. DO NOT edit this file manually. -->

        <h2 align="center">List of Packages and Flakes</h2>

        ## Packages

        ${pkgsList}

        ## Flakes

        ${flakesList}
      '';

    /*
      Generates a derivation to wrap the Odin compiler from a pre-built binary.
      Needed for packages `odin` and `odin-nightly`.

      Type: AttrSet -> Derivation
    */
    odinDerivation =
      { stdenv
      , makeBinaryWrapper
      , llvmPackages_latest
      , odin

      , pkg ? { }
      , pname ? ""
      , llvmPackages ? llvmPackages_latest
      }:
      stdenv.mkDerivation (newAttrs:
      pkg // {
        inherit pname;

        nativeBuildInputs = [
          makeBinaryWrapper
        ];

        buildPhase = ''
          runHook preBuild

          make -C vendor/cgltf/src
          make -C vendor/stb/src
          make -C vendor/miniaudio/src

          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall

          mkdir -p $out/bin
          mv odin $out/bin/odin

          mkdir -p $out/share
          mv base $out/share/base
          mv core $out/share/core
          mv vendor $out/share/vendor
          mv shared $out/share/shared

          wrapProgram $out/bin/odin \
            --prefix PATH : ${lib.makeBinPath (with llvmPackages; [
              bintools
              llvm
              clang
              lld
            ])} \
            --set-default ODIN_ROOT $out/share

          runHook postInstall
        '';

        meta = odin.meta // {
          maintainers = with lib.maintainers; [ spitulax ];
        };
      });
  };

  /*
    These are used inside inline bash scripts.
    Some of them need to be accessed with `callPackage`.
  */
  shell = rec {
    nixCmd = nix: "${getExe nix} --experimental-features 'nix-command flakes'";

    serialiseJSON = { jq }: val: "echo \"" + escape [ "\"" ] (toJSON val) + "\" | ${getExe jq} .";

    runScripts = scripts:
      concatStringsSep "\n" (map (x: "${x}") scripts);

    importJSON = { jq }: json: filt:
      "$(echo \"${json}\" | ${getExe jq} -r \"${filt}\")";

    ghApi = { gh }: endpoint:
      "$(${getExe gh} api --method GET \"${endpoint}\" --header 'Accept: application/vnd.github+json')";

    getFileHash =
      { nix
      , jq
      , callPackage
      }:
      { url
      , archive ? null
      , executable ? false
      }:
      let
        archive' =
          if archive == null
          then isArchive url
          else archive;

        importJSON' = callPackage importJSON { };
      in
      "${importJSON' (
        "$(${nixCmd nix} store prefetch-file --json --name source "
        + (optionalString archive' "--unpack ")
        + (optionalString executable "--executable ")
        + "\"${url}\")"
      )
      ".hash"}";

    echo = val:
      "echo \"${val}\"";
  };
}

