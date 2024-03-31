{ config
, pkgs
, lib
, ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      command_timeout = 5000;
      format = lib.concatStrings [
        "$nix_shell"
        "$cmd_duration"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$shlvl"
        "$character"
      ];

      character = {
        format = "$symbol ";
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
        vimcmd_symbol = "[󰄾](bold green)";
        vimcmd_replace_one_symbol = "[󰄾](bold yellow)";
        vimcmd_replace_symbol = "[󰄾](bold yellow)";
        vimcmd_visual_symbol = "[󰄾](bold blue)";
        disabled = false;
      };

      cmd_duration = {
        min_time = 5000;
        show_milliseconds = false;
        format = "[$duration ]($style)";
        style = "bold yellow";
        disabled = false;
      };

      directory = {
        truncation_length = 2;
        truncate_to_repo = false;
        format = "[$path]($style)[$read_only]($read_only_style) ";
        read_only = "";
        read_only_style = "red";
        truncation_symbol = "../";
        home_symbol = "~";
        use_os_path_sep = true;
        disabled = false;
      };

      line_break = {
        disabled = true;
      };

      git_branch = {
        always_show_remote = false;
        format = "[$branch]($style) ";
        style = "bold purple";
        truncation_symbol = "..";
        only_attached = false;
        ignore_branches = [ ];
        disabled = false;
      };

      git_commit = {
        commit_hash_length = 7;
        format = "[$hash$tag]($style) ";
        style = "bold green";
        only_detached = false;
        tag_disabled = false;
        tag_symbol = "#";
        disabled = true;
      };

      git_state = {
        rebase = "rebasing";
        merge = "merging";
        revert = "reverting";
        cherry_pick = "cherry-picking";
        bisect = "bisecting";
        am = "am";
        am_or_rebase = "am/rebase";
        format = "[$state $progress_current/$progress_total]($style) ";
        style = "bold yellow";
        disabled = false;
      };

      git_metrics = {
        added_style = "green";
        deleted_style = "red";
        only_nonzero_diffs = false;
        format = "[$added]($added_style)[$deleted]($deleted_style) ";
        disabled = false;
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
        style = "bold green";
        conflicted = " ";
        ahead = " ";
        behind = " ";
        diverged = " ";
        up_to_date = " ";
        untracked = " ";
        stashed = " ";
        modified = " ";
        staged = " ";
        renamed = " ";
        deleted = " ";
        disabled = true;
      };

      nix_shell = {
        format = "[$symbol$state]($style)";
        style = "bold blue";
        symbol = "  ";
        impure_msg = "";
        heuristic = false;
        disabled = false;
      };

      shlvl = {
        format = "[$shlvl]($style)";
        disabled = true;
      };
    };
  };
}
