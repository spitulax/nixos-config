{ lib
, rustPlatform
, debug ? false
}:
let
  version = with lib; elemAt
    (pipe (readFile ../Cargo.toml) [
      (splitString "\n")
      (filter (hasPrefix "version = "))
      head
      (splitString " = ")
      last
      (splitString "\"")
    ]) 1;
in
rustPlatform.buildRustPackage ({
  pname = "foobar";
  inherit version;
  src = lib.cleanSource ./..;

  cargoLock = {
    lockFile = ../Cargo.lock;
    allowBuiltinFetchGit = true;
  };
} // (
  if debug then {
    buildType = "debug";
    dontStrip = true;
  }
  else { }
))
