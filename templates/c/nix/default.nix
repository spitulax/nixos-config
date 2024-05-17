{ stdenv
, lib
, debug ? false
}:
stdenv.mkDerivation {
  pname = "foobar";
  version = "0.1.0";
  src = lib.cleanSource ./..;

  buildInputs = [

  ];

  makeFlags = [ "PREFIX=$(out)" ] ++ lib.optionals (!debug) [ "RELEASE=1" ];
}
