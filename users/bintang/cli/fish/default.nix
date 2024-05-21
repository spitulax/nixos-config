{ pkgs
, ...
}: {
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      # eza
      ls = "eza -G -laH --no-user --color=always --group-directories-first --icons";
      lr = "eza -G --no-user --color=always --group-directories-first --icons";
      la = "eza -G -a --no-user --color=always --group-directories-first --icons";
      ll = "eza -G -lH --no-user --color=always --group-directories-first --icons";
      lt = "eza -G -T --no-user --color=always --group-directories-first --icons --long -L";
      ols = "/usr/bin/env ls";
      # shortcuts
      vim = "nvim";
      repl = "nix repl .";
      nrepl = "nix repl -f flake:nixpkgs";
      pkgs-user = "nix-store -qR $HOME/.nix-profile";
      pkgs-sys = "nix-store -qR /run/current-system/sw";
      ".." = "cd ..";
      "..." = "cd ../..";
      q = "exit";
      rm = "trash-put -v";
      orm = "/usr/bin/env rm";
      restore = "trash-restore";
      make = "make -C (dirname (upfind . -name Makefile))";
      cat = "_fzf_preview_file";
      # colorizer
      grep = "grep --color";
      egrep = "egrep --color";
      fgrep = "fgrep --color";
      # misc
      # this will wipe the scoll buffer instead of just zt-ing the current prompt
      clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
      # cofirm before overwriting files
      cp = "cp -i";
      mv = "mv -i";
    };

    interactiveShellInit = builtins.readFile ./init.fish;

    plugins = [
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "v10.3";
          hash = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
        };
      }
    ];
  };
}
