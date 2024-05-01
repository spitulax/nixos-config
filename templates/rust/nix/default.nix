{ lib
, rustPlatform
, debug ? false
}:

rustPlatform.buildRustPackage ({
  pname = "foobar";
  version = "0.1.0";
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
