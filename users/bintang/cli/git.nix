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

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
      hosts = [ "https://github.com" "https://gist.github.com" ];
    };
    settings = {
      editor = "nvim";
      git_protocol = "ssh";
    };
  };
}
