{ lib }: rec {
  /*
    Returns true if the given file has the given extension.

    Inputs:
      - `ext`: The extension to check for
      - `file`: The file's name

    Type: Path/String -> Bool
  */
  checkExt = ext: file:
    lib.last (builtins.split "\\.${ext}$" (builtins.toString file)) == "";

  /*
    Truncate the last extension in the given file name.

    Inputs:
      - `ext`: The extension to truncate
      - `file`: The file's name

    Type: Path/String -> Bool
  */
  truncateExt = ext: file:
    if checkExt ext file
    then builtins.head (builtins.split "\\.${ext}$" (builtins.toString file))
    else file;

  /*
    Returns a list of files in given directory.

    Inputs:
    - `dir`: The directory that contains the files
    - `types`: A list of included file types or pass [] if no files should be filtered. The possible values are "regular", "directory", "symlink" and "unknown"

    Type: Path -> [String] -> [String]
  */
  listFilesAll = dir: types:
    (builtins.attrNames
      (lib.filterAttrs
        (_: v: types == [ ] || builtins.elem v types)
        (builtins.readDir dir)));


  /*
    Wrappers to `listFilesAll` that only include either regular files or directories.

    Inputs:
      - `dir`: The directory that contains the files

    Type: Path -> [String]
  */
  listFiles = dir: listFilesAll dir [ "regular" ];
  listDirs = dir: listFilesAll dir [ "directory" ];


  /*
     Returns a list of regular files in given directory that have given extension.

    Inputs:
      - `dir`: The directory that contains the files
      - `ext`: The file extension (without leading period)

    Type: Path -> String -> [String]
  */
  listFilesExt = dir: ext:
    (builtins.filter
      (checkExt ext)
      (listFiles dir));


  /*
    Same as `listFilesExt` but with each file's extension removed.

    Inputs:
      - `dir`: The directory that contains the files
      - `ext`: The file extension (without leading period)

    Type: Path -> String -> [String]
  */
  listFilesExtTruncate = dir: ext:
    builtins.map
      (truncateExt ext)
      (listFilesExt dir ext);


  /*
    Generates an attribute set with each file in given directory as its name.

    Inputs:
      - `dir`: The directory that contains the files
      - `types`: A list of included file types or pass [] if no files should be filtered. The possible values are "regular", "directory", "symlink" and "unknown"
      - `f`: Function that takes the file path and name that generates the attribute's value

    Type: Path -> [String] -> (Path -> String -> Any) -> AttrSet
  */
  genAttrsEachFileAll = dir: types: f:
    lib.genAttrs
      (listFilesAll dir types)
      (n: f /${dir}/${n} n);


  /*
    Generates an attribute set from specified files in given directory.

    Inputs:
      - `dir`: The directory that contains the files
      - `names`: The name of the files relative to `dir`
      - `f`: Function that takes the file path and name that generates the attribute's value

    Type: Path -> [String] -> (Path -> String -> Any) -> AttrSet
  */
  genAttrsEachFileManual = dir: names: f:
    lib.genAttrs
      names
      (n: f /${dir}/${n} n);


  /*
    Wrappers to `genAttrsEachFile` that only include either regular files or directories.

    Inputs:
      - `dir`: The directory that contains the files
      - `f`: Function that takes the file path and name that generates the attribute's value

    Type: Path -> (Path -> String -> Any) -> AttrSet
  */
  genAttrsEachFile = dir: f: genAttrsEachFileAll dir [ "regular" ] f;
  genAttrsEachDir = dir: f: genAttrsEachFileAll dir [ "directory" ] f;


  /*
    This function is similar to `genAttrsEachFile` but it also includes files from subdirectories recursively.
    Directories are turned into an attrset of subdirectories or regular files.
    Regular files are turned into a string that represent a path relative to `dir`.

    Inputs:
      - `dir`: The topmost/starting directory
      - `f`: Function that takes the file path and name (relative to `dir`) that generates the attribute's value

    Type: Path -> (Path -> String -> Any) -> AttrSet
  */
  genAttrsEachFileRec = dir: f:
    let
      gen = dir: dirFunc: fileFunc:
        genAttrsEachDir dir dirFunc
        // genAttrsEachFile dir fileFunc;
      f' = prevn: p: n:
        f /${p} (prevn + "/" + n);
    in
    gen dir (p: n: genAttrsEachFileRec (lib.path.append dir n) (f' n)) f;


  /*
    A wrapper to `genAttrsEachFile` that only includes files that have given extension and remove the file extension in the attribute's name.

    Inputs:
      - `dir`: The directory that contains the files
      - `ext`: The file extension (without leading period)
      - `f`: Function that takes the file path and name that generates the attribute's value

    Example:
      Given these files in `./.`: [ "README.md" "flake.nix" "flake.lock" "default.nix" ]
      ```
      genAttrsEachFileExt ./. "nix" (p: n: "${p} ${n}")
        => { flake = "/nix/store/...-flake.nix flake.nix"; default = "/nix/store/...-default.nix default.nix"; }
      ```

    Type: Path -> String -> (Path -> String -> Any) -> AttrSet
  */
  genAttrsEachFileExt = dir: ext: f:
    let
      filterExt =
        lib.filterAttrs
          (n: _: checkExt ext n);
      truncateExt' =
        lib.mapAttrs'
          (n: lib.nameValuePair (truncateExt ext n));
    in
    truncateExt' (filterExt (genAttrsEachFile dir f));


  /*
    A wrapper to `genAttrsEachFileManual` that only includes files that have given extension and remove the file extension in the attribute's name.

    Inputs:
      - `dir`: The directory that contains the files
      - `ext`: The file extension (without leading period)
      - `names`: The name of the files relative to `dir`
      - `f`: Function that takes the file path and name that generates the attribute's value

    Example:
      Given these files in `./.`: [ "README.md" "flake.nix" "flake.lock" "default.nix" ]
      ```
      genAttrsEachFileExt ./. "nix" [ "flake" "default" ] (p: n: "${p} ${n}")
        => { flake = "/nix/store/...-flake.nix flake.nix"; default = "/nix/store/...-default.nix default.nix"; }
      ```

    Type: Path -> String -> (Path -> String -> Any) -> AttrSet
  */
  genAttrsEachFileExtManual = dir: ext: names: f:
    lib.genAttrs
      names
      (n: f /${dir}/${n}.${ext} n);


  /*
    Same as `genAttrsEachFileRec` but only includes regular files that have given extension and remove the file extension in the attribute's name.
    If there is a regular file that has the same name as a directory after the extension has been stripped, the regular file takes precedence over the directory.

    Inputs:
      - `dir`: The topmost/starting directory
      - `ext`: The file extension (without leading period)
      - `f`: Function that takes the file path and name (relative to `dir`) that generates the attribute's value

    Type: Path -> String -> (Path -> String -> Any) -> AttrSet
  */
  genAttrsEachFileExtRec = dir: ext: f:
    let
      gen = dir: dirFunc: fileFunc:
        genAttrsEachDir dir dirFunc
        // genAttrsEachFileExt dir ext fileFunc;
      f' = prevn: p: n:
        f /${p} (prevn + "/" + n);
    in
    gen dir (p: n: genAttrsEachFileExtRec (lib.path.append dir n) ext (f' n)) f;


  /*
    Generates an attribute set containing boolean module options.
    The description by default is "Whether to enable ${name}.".

    Inputs:
      - `names`: List of the options' name

    Type: [String] -> AttrSet
  */
  mkEnableOptions = names:
    mkEnableOptions' names (n: "Whether to enable ${n}.");


  /*
    Same as `mkEnableOptions` but the function for generating descriptions is specifiable.

    Inputs:
      - `names`: List of the options' name
      - `desc`: Function that takes an option's name and returns the description for it

    Type: [String] -> (String -> String) -> AttrSet
  */
  mkEnableOptions' = names: desc:
    lib.genAttrs
      names
      (n: lib.mkEnableOption "" // { description = desc n; });


  /*
    Takes an attribute set and remove the attribute that is null.

    Inputs:
    - `attrs`: Attribute set to be stripped

    Type: AttrSet -> AttrSet
  */
  stripAttrs = attrs:
    lib.filterAttrs (_: v: v != null) attrs;


  # DOCS: need docs

  mkDate = longDate: (lib.concatStringsSep "-" [
    (builtins.substring 0 4 longDate)
    (builtins.substring 4 2 longDate)
    (builtins.substring 6 2 longDate)
  ]);


  mkFlakeVersion = flake:
    mkDate (flake.lastModifiedDate or "19700101")
    + "_" + (flake.rev or "dirty");
}
