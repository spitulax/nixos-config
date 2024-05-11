{ lib }: rec {
  /*
    Signature: Path -> [ String ] -> (String -> Any) -> AttrSet
    Arguments:
      - dir: directory that contains the files
      - types: list of included file types or pass [] if no files should be filtered
      ->  The possible values are "regular", "directory", "symlink" and "unknown"
      - f: function that takes the file name that generates the attrset's value
    
    Same as `lib.genAttrs` but generates an attrset on each files in given directory as the name
  */
  genAttrsEachFilesAll = dir: types: f:
    lib.genAttrs
      (builtins.attrNames
        (lib.filterAttrs
          (_: v:
            if types != [ ] then
              builtins.elem v types
            else
              true)
          (builtins.readDir dir)))
      f;

  /*
    Signature: Path -> (String -> Any) -> AttrSet
    Arguments: see `genAttrsEachFilesAll`

    These functions are wrappers to `genAttrsEachFiles` that only include either regular files or directories
  */
  genAttrsEachFiles = dir: f: genAttrsEachFilesAll dir [ "regular" ] f;
  genAttrsEachDirs = dir: f: genAttrsEachFilesAll dir [ "directory" ] f;

  /*
    Signature: Path -> String -> (String -> Any) -> AttrSet
    Arguments:
      - ext: included files' extension (without leading period)
      - see `genAttrsEachFilesAll`

    This function is a wrapper to `genAttrsEachFiles` that only includes files that have given extension
    and remove the file extension in the attrset's name

    Example:
    Note: Given these files in `./.`: [ "README.md" "flake.nix" "flake.lock" "default.nix" ]
    genAttrsEachFilesExt ./. "nix" (n: n)
      => { flake = "flake.nix"; default = "default.nix"; }
  */
  genAttrsEachFilesExt = dir: ext: f:
    builtins.listToAttrs
      (builtins.map
        (v: v // {
          name = (builtins.head (builtins.split "\.${ext}$" v.name));
        })
        (lib.attrsToList
          (lib.filterAttrs
            (n: _: lib.last (builtins.split "\.${ext}$" n) == "")
            (genAttrsEachFiles dir f))));
}
