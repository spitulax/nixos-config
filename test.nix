{ lib, myLib }:
let
  genAttrsEach = dir: f:
    myLib.genAttrsEachDirs dir f
    // myLib.genAttrsEachFilesExt dir "nix" f;
  genAttrsEach2 = dir: fdir: ffile:
    myLib.genAttrsEachDirs dir fdir
    // myLib.genAttrsEachFilesExt dir "nix" ffile;
in
rec {
  gen = path:
    if builtins.readFileType path == "directory" then
      genAttrsEach path (n: gen (lib.path.append path n))
    else
      path;
  gen2 = path:
    genAttrsEach2 path (n: gen2 (lib.path.append path n)) (lib.path.append path);
}

