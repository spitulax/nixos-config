{ pkgs }:
let
  inherit (pkgs) fetchFromGitHub;
in
[
  (fetchFromGitHub {
    owner = "dedukun";
    repo = "bookmarks.yazi";
    rev = "08b3f85c5d52656157a55e10410050b042f5b314";
    hash = "sha256-t3MKmmNABMMphnfpIOQiSfn34HwNo8RkWr7+jeD7xfI=";
  })

  (fetchFromGitHub {
    owner = "Reledia";
    repo = "glow.yazi";
    rev = "536185a4e60ac0adc11d238881e78678fdf084ff";
    hash = "sha256-NcMbYjek99XgWFlebU+8jv338Vk1hm5+oW5gwH+3ZbI=";
  })

  (fetchFromGitHub {
    owner = "Reledia";
    repo = "hexyl.yazi";
    rev = "64daf93a67d75eff871befe52d9013687171ffad";
    hash = "sha256-B2L3/Q1g0NOO6XEMIMGBC/wItbNgBVpbaMMhiXOYcrI=";
  })

  (fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    rev = "694d149be5f96eaa0af68d677c17d11d2017c976";
    hash = "sha256-J3vR9q4xHjJt56nlfd+c8FrmMVvLO78GiwSNcLkM4OU=";
  })

  (fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "92366cf0b024a05cb80c9e245408026dcabe94f2";
    hash = "sha256-QAIUwArdMvTxSRTXDg72rk1E2JresC4KzADqIPXnKLE=";
  })

  (fetchFromGitHub {
    owner = "DreamMaoMao";
    repo = "git-status.yazi";
    rev = "4488bd23ab1f33ef136abcf22cfdbc32fea621d0";
    hash = "sha256-KlnhOuluyHron8JvfxzeFQK4Pma7bOvGaMbynhyq3ZU=";
  })
]
