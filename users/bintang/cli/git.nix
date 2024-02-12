{ config
, pkgs
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
        name = "Bintang";
        email = "bintangadiputrapratama@gmail.com";
        signing.key = "CEA66159F05DBA82253ACDEC4B7E05AA0F905C0D";
      };
      commit.gpgSign = true;
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
  };
}
