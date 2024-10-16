{ pkgs }:
let
  inherit (pkgs) fetchFromGitHub;
in
[
  # https://github.com/dedukun/bookmarks.yazi
  (fetchFromGitHub {
    owner = "dedukun";
    repo = "bookmarks.yazi";
    rev = "600f87c02176175f55b0571f79c5ff0b1606362f";
    hash = "sha256-pNRRxS4IQO8y8/WSK9s8mNZHEdl1u1cuPfdULxikl7k=";
  })

  # https://github.com/Reledia/glow.yazi
  (fetchFromGitHub {
    owner = "Reledia";
    repo = "glow.yazi";
    rev = "d8b36ff0113e73a400891726dc2eca8b3c049dea";
    hash = "sha256-fKJ5ld5xc6HsM/h5j73GABB5i3nmcwWCs+QSdDPA9cU=";
  })

  # https://github.com/Reledia/hexyl.yazi
  (fetchFromGitHub {
    owner = "Reledia";
    repo = "hexyl.yazi";
    rev = "f845ea5e198f6b63545534e644527e1d120d8ee8";
    hash = "sha256-Ggkns5gEnciyRBKM4+5l51DVP2GhVm86cb6JOige1XM=";
  })

  # https://github.com/ndtoan96/ouch.yazi
  (fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    rev = "251da6930ca8b7ee0384810086c3bf644caede3e";
    hash = "sha256-yLt9aY6hUIOdBI5bMdCs7VYFJGyD3WIkmPxvWKNCskA=";
  })

  # https://github.com/Sonico98/exifaudio.yazi
  (fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "d75db468e89ab379992c21cb745ca7920d5f409f";
    hash = "sha256-ECo0rTDF+oqRtRsqrhBuVdZtEpJShRk/XXhPwEy4cfE=";
  })
]
