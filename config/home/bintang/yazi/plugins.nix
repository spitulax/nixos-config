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
    rev = "388e847dca6497cf5903f26ca3b87485b2de4680";
    hash = "sha256-fKJ5ld5xc6HsM/h5j73GABB5i3nmcwWCs+QSdDPA9cU=";
  })

  # https://github.com/Reledia/hexyl.yazi
  (fetchFromGitHub {
    owner = "Reledia";
    repo = "hexyl.yazi";
    rev = "ccc0a4a959bea14dbe8f2b243793aacd697e34e2";
    hash = "sha256-9rPJcgMYtSY5lYnFQp3bAhaOBdNUkBaN1uMrjen6Z8g=";
  })

  # https://github.com/ndtoan96/ouch.yazi
  (fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    rev = "d13f7c08cdebcfaadf38c3eb9999639ddd89201c";
    hash = "sha256-Ii0gowsx6fegFNaOtThAbKaKa2WF1uavgzeONRPaQGU=";
  })

  # https://github.com/Sonico98/exifaudio.yazi
  (fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "855ff055c11fb8f268b4c006a8bd59dd9bcf17a7";
    hash = "sha256-8f1iG9RTLrso4S9mHYcm3dLKWXd/WyRzZn6KNckmiCc=";
  })
]
