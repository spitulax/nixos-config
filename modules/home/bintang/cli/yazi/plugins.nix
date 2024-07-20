{ pkgs }:
let
  inherit (pkgs) fetchFromGitHub;
in
[
  (fetchFromGitHub {
    owner = "dedukun";
    repo = "bookmarks.yazi";
    rev = "748efed3b985ae4107439c7e868e1fbf6a90c3a3";
    hash = "sha256-AiRd8wUHDrvjI3Gct9Q90RE9I43JEolYOd1kh1bAWSE=";
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
    rev = "251da6930ca8b7ee0384810086c3bf644caede3e";
    hash = "sha256-yLt9aY6hUIOdBI5bMdCs7VYFJGyD3WIkmPxvWKNCskA=";
  })

  (fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "92366cf0b024a05cb80c9e245408026dcabe94f2";
    hash = "sha256-QAIUwArdMvTxSRTXDg72rk1E2JresC4KzADqIPXnKLE=";
  })
]
