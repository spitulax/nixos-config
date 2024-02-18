{ config
, pkgs
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
      # shortcuts
      vim = "nvim";
      ".." = "cd ..";
      "..." = "cd ../..";
      q = "exit";
      rm = "trash-put";
      prm = "/usr/bin/env rm";
      restore = "trash-restore";
      cat = "bat"; # colorful cat (not lolcat)
      # colorizer
      grep = "grep --color";
      egrep = "egrep --color";
      fgrep = "fgrep --color";
      # misc
      # this will wipe the scoll buffer instead of just zt-ing the current prompt
      clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
    };

    functions = {
      # Remove fish intro
      fish_greeting = "";
      # !! and !$ command
      __history_previous_command = ''
        switch (commandline -t)
        case "!"
          commandline -t $history[1]; commandline -f repaint
        case "*"
          commandline -i !
        end
      '';
      __history_previous_command_arguments = ''
        switch (commandline -t)
        case "!"
          commandline -t ""
          commandline -f history-token-search-backward
        case "*"
          commandline -i '$'
        end
      '';
    };

    interactiveShellInit = ''
      # Vi mode
      fish_vi_key_bindings

      # Cursor appearance indicates mode
      set fish_cursor_default     block      blink
      set fish_cursor_insert      line       blink
      set fish_cursor_replace_one underscore blink
      set fish_cursor_visual      block

      # Enable !! and !$ command
      if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
        bind -Minsert ! __history_previous_command
        bind -Minsert '$' __history_previous_command_arguments
      else
        bind ! __history_previous_command
        bind '$' __history_previous_command_arguments
      end
    '';
  };
}
