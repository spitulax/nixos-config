{ config
, ...
}: {
  programs.git = {
    enable = true;
    extraConfig = {
      core = {
        eol = "lf";
        editor = "nvim";
      };
      diff = {
        tool = "difftool-nvim";
        prompt = false;
      };
      "difftool \"difftool-nvim\"" = {
        cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
      };
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "Bintang Adiputra Pratama";
        email = "bintangadiputra@proton.me";
        signingkey = "929ED6C40414D3F5";
      };
      commit.gpgSign = true;
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
  };
}
