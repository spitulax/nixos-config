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
      };
    };
  };
}
