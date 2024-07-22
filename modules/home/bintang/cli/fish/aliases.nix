{
  programs.fish = {
    shellAliases = {
      # eza
      ls = "eza -G -laH --no-user --color=always --group-directories-first --icons";
      lr = "eza -G --no-user --color=always --group-directories-first --icons";
      la = "eza -G -a --no-user --color=always --group-directories-first --icons";
      ll = "eza -G -lH --no-user --color=always --group-directories-first --icons";
      lt = "eza -G -T --no-user --color=always --group-directories-first --icons --long -L";
      oldls = "/usr/bin/env ls";
      # nix shortcuts
      repl = "nix repl .";
      nrepl = "nix repl -f flake:nixpkgs";
      pkgs-user = "nix-store -qR $HOME/.nix-profile";
      pkgs-sys = "nix-store -qR /run/current-system/sw";
      gcroots = "nix-store --gc --print-roots | less";
      profile-hist = "nix profile history --profile";
      upinput = "nix flake lock --update-input";
      # misc. shortcuts
      vim = "nvim";
      ".." = "cd ..";
      "..." = "cd ../..";
      q = "exit";
      rm = "trash-put -v";
      oldrm = "/usr/bin/env rm";
      restore = "trash-restore";
      cat = "bat --style numbers";
      oldcat = "/usr/bin/env cat";
      old = "command";
      j = "jobs";
      f = "fg";
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
  };
}
