{ lib }: rec {
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
      (v: lib.last (builtins.split "\\.${ext}$" v) == "")
      (listFiles dir));


  /*
    Generates an attribute set with each files in given directory as its name.

    Inputs:
      - `dir`: The directory that contains the files
      - `types`: A list of included file types or pass [] if no files should be filtered. The possible values are "regular", "directory", "symlink" and "unknown"
      - `f`: Function that takes the file name that generates the attribute's value

    Type: Path -> [String] -> (String -> Any) -> AttrSet
  */
  genAttrsEachFilesAll = dir: types: f:
    lib.genAttrs
      (listFilesAll dir types)
      f;


  /*
    Wrappers to `genAttrsEachFiles` that only include either regular files or directories.
    
    Inputs:
      - `dir`: The directory that contains the files
      - `f`: Function that takes the file name that generates the attribute's value

    Type: Path -> (String -> Any) -> AttrSet
  */
  genAttrsEachFiles = dir: f: genAttrsEachFilesAll dir [ "regular" ] f;
  genAttrsEachDirs = dir: f: genAttrsEachFilesAll dir [ "directory" ] f;

  /*
    This function is similar to `genAttrsEachFiles` but it also includes files from subdirectories recursively.
    Directories are turned into an attrset of subdirectories or regular files.
    Regular files are turned into a string that represent a path relative to `dir`.
    
    Inputs:
      - `dir`: The topmost/starting directory
      - `f`: Function that takes the file path (relative to `dir`) that generates the attribute's value

    Type: Path -> (String -> Any) -> AttrSet
  */
  genAttrsEachFilesRec = dir: f:
    let
      gen = dir: dirFunc: fileFunc:
        genAttrsEachDirs dir dirFunc
        // genAttrsEachFiles dir fileFunc;
      f' = prevn: n: f (prevn + "/" + n);
    in
    gen dir (n: genAttrsEachFilesRec (lib.path.append dir n) (f' n)) f;


  /*
    A wrapper to `genAttrsEachFiles` that only includes files that have given extension and remove the file extension in the attribute's name.

    Inputs:
      - `dir`: The directory that contains the files 
      - `ext`: The file extension (without leading period)
      - `f`: Function that takes the file name that generates the attribute's value

    Example:
      Given these files in `./.`: [ "README.md" "flake.nix" "flake.lock" "default.nix" ]
      ```
      genAttrsEachFilesExt ./. "nix" lib.id
        => { flake = "flake.nix"; default = "default.nix"; }
      ```

    Type: Path -> String -> (String -> Any) -> AttrSet
  */
  genAttrsEachFilesExt = dir: ext: f:
    let
      filterExt =
        lib.filterAttrs
          (n: _: lib.last (builtins.split "\\.${ext}$" n) == "");
      truncateExt =
        lib.mapAttrs'
          (n: lib.nameValuePair (builtins.head (builtins.split "\\.${ext}$" n)));
    in
    truncateExt (filterExt (genAttrsEachFiles dir f));


  /*
    Same as `genAttrsEachFilesRec` but only includes regular files that have given extension and remove the file extension in the attribute's name.
    If there is a regular file that has the same name as a directory after the extension has been stripped, the regular file takes precedence over the directory.

    Inputs:
      - `dir`: The topmost/starting directory
      - `ext`: The file extension (without leading period)
      - `f`: Function that takes the file path (relative to `dir`) that generates the attribute's value

    Type: Path -> String -> (String -> Any) -> AttrSet
  */
  genAttrsEachFilesExtRec = dir: ext: f:
    let
      gen = dir: dirFunc: fileFunc:
        genAttrsEachDirs dir dirFunc
        // genAttrsEachFilesExt dir ext fileFunc;
      f' = prevn: n: f (prevn + "/" + n);
    in
    gen dir (n: genAttrsEachFilesExtRec (lib.path.append dir n) ext (f' n)) f;


  /*
    Returns an attribute set that can be used to simplify imports.
    Use this inside a `default.nix` file to import all nix files or directories containing nix files.

    Inputs:
      `dir`: The directory that contains the files/directories to be imported.

    Example:
      Given `./.`:
        | mod1/
        | mod2/
        | default.nix (current file)
        | other.nix
      ```
      importIn ./.
        => {
          imports = [
            ./mod1
            ./mod2
            other.nix
          ];
        }
      ```

    Type: Path -> AttrSet
  */
  importIn = dir:
    {
      imports =
        let
          files = listFilesExt dir "nix" ++ listDirs dir;
        in
        builtins.map
          (lib.path.append dir)
          (builtins.filter (v: v != "default.nix") files);
    };
}
