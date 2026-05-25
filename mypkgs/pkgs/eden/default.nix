{ pkgs
, fetchFromGitHub
, qt6
, giteaPkg
, lib
}:
let
  httplib = pkgs.httplib.overrideAttrs rec {
    version = "0.18.7";
    src = fetchFromGitHub {
      owner = "yhirose";
      repo = "cpp-httplib";
      rev = "v${version}";
      hash = "sha256-DkET7D2hF6xlrYWEGC87rFqEe1JjMS3SHX6QFSi1oQg=";
    };
  };

  sdl3 = (pkgs.sdl3.overrideAttrs rec {
    version = "3.2.10";
    src = fetchFromGitHub {
      owner = "libsdl-org";
      repo = "SDL";
      tag = "release-${version}";
      hash = "sha256-SylXpHPT4Y/37UapfLScJJ/CGniNyK4UNVAWax+WiBo=";
    };
  }).override {
    waylandSupport = false;
  };

  src = giteaPkg {
    domain = "git.eden-emu.dev";
    owner = "eden-emu";
    repo = "eden";
    ref = "master";
  };
in
(pkgs.eden.overrideAttrs (_: prevAttrs: src // {
  patches = [ ];
  buildInputs = prevAttrs.buildInputs ++ [
    qt6.qtcharts
    sdl3
  ];
  postInstall = null;
})).override {
  inherit httplib;
}
