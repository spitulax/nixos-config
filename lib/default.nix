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


  /*
    Separates the elements from a date with format "YYYYMMDD" to "YYYY-MM-DD".

    Inputs:
    - `longDate`: The unseparated date

    Type: String -> String
  */
  mkDate = longDate: (lib.concatStringsSep "-" [
    (builtins.substring 0 4 longDate)
    (builtins.substring 4 2 longDate)
    (builtins.substring 6 2 longDate)
  ]);


  /*
    Takes a flake object and returns a string indicating its version with format "YYYY-MM-DD_REV".

    Inputs:
    - `flake`: The flake object

    Type: AttrSet -> String
  */
  mkFlakeVersion = flake:
    mkDate (flake.lastModifiedDate or "19700101")
    + "_" + (flake.rev or "dirty");


  /*
    Defines a set of options inside Home Manager config and their respective config when enabled.
  */
  hmHelper = {
    /*
      Defines options to add aliases to shells.
    */
    alias = {
      /*
        An attribute set, the attributes are for each shells passed to `mkOptions`.
        Each attribute is a boolean option.
        Example:
        {
          fish = lib.mkOptions ...;
          bash = lib.mkOptions ...;
        }
      */
      mkOptions =
        {
          # String :: The name of the thing being aliased.
          desc
          # [String] :: Generate options for the given shells.
        , shells ? [ "fish" "bash" ]
        }:
        let
          option = name: {
            ${name} = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = "Whether to alias ${desc} in ${name}.";
            };
          };
        in
        lib.mergeAttrsList (map option shells);

      /*
        Generates config for each enabled shell for defining the aliases.
        Assign to `programs`.
      */
      mkConfig =
        {
          # AttrSet :: The config object.
          config
          # AttrSet :: An attribute set of strings.
          # The attribute names are the aliases and the values are the expanded commands.
        , aliases
          # AttrSet :: Extra aliases. The same type as `aliases`.
        , extraAliases ? { }
        }:
        lib.mergeAttrsList
          (lib.mapAttrsToList
            (k: v: {
              ${k}.shellAliases = lib.optionalAttrs v (aliases // extraAliases);
            })
            config);
    };


    /*
      Defines options to add packages.

      Module format:
      {
        <option name> = {
          desc :: String: The option description.
          pkgs :: [Package]: The packages to be added.
        };
      }
    */
    packages = {
      /*
        An attribute set, the attributes are for each attribute in the module.
        Each attribute is an attribute set containing an "enable" option.
        Example:
        {
          hello = {
            enable = lib.mkEnableOption ...;
          };
        }
      */
      mkOptions =
        {
          # String -> String :: Takes `desc` from the module and returns the altered description.
          desc ? lib.id
          # Module :: The module.
        , modules
        }:
        lib.mapAttrs
          (k: v: {
            enable = lib.mkEnableOption (desc v.desc) // {
              default = v.default or false;
            };
          })
          modules;

      /*
        Generates config for each enabled module for adding the packages.
        Assign to `home.packages`.
      */
      mkConfig =
        {
          # Module :: The module.
          modules
          # AttrSet :: The config object.
        , cfg
        }: lib.flatten
          (lib.mapAttrsToList
            (_: v: v.pkgs)
            (lib.filterAttrs
              (_: v: v.enable)
              (lib.mapAttrs
                (k: v: {
                  inherit (cfg.${k}) enable;
                  inherit (v) pkgs;
                })
                modules)));
    };
  };
}
