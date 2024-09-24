{ pkgs }:
let
  inherit (pkgs) fetchFromGitHub;
in
[
  (fetchFromGitHub {
    owner = "dedukun";
    repo = "bookmarks.yazi";
    rev = "600f87c02176175f55b0571f79c5ff0b1606362f";
    hash = "sha256-pNRRxS4IQO8y8/WSK9s8mNZHEdl1u1cuPfdULxikl7k=";
  })

  (fetchFromGitHub {
    owner = "Reledia";
    repo = "glow.yazi";
    rev = "4e016fa2357e5e7e9b1a4881e1492d73a0a2f2cc";
    hash = "sha256-d73C8s8p85c0xfq8Nfzlnp83JUakMPbviQDFCX0G+qE=";
  })

  (fetchFromGitHub {
    owner = "Reledia";
    repo = "hexyl.yazi";
    rev = "f845ea5e198f6b63545534e644527e1d120d8ee8";
    hash = "sha256-Ggkns5gEnciyRBKM4+5l51DVP2GhVm86cb6JOige1XM=";
  })

  (fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    rev = "251da6930ca8b7ee0384810086c3bf644caede3e";
    hash = "sha256-yLt9aY6hUIOdBI5bMdCs7VYFJGyD3WIkmPxvWKNCskA=";
  })

  (fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "6205460405fa39c017d0eef12997c1180658e695";
    hash = "sha256-mYvq7xnd4gI0KoG5G+ygDxqCWdpZbMn3Im1EiW3eSyI=";
  })
]
