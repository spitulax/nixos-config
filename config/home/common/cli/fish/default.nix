{ config
, pkgs
, lib
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkMerge
    mkIf
    concatStrings
    ;

  cfg = config.configs.cli.fish;
in
{
  options.configs.cli.fish = {
    enable = mkEnableOption "fish shell" // {
      default = true;
    };
    atuin = mkEnableOption "atuin";
    starship = mkEnableOption "starship prompt" // {
      default = true;
    };
    zoxide = mkEnableOption "zoxide" // {
      default = true;
    };
    crt = mkEnableOption "Commands Run Today" // {
      default = true;
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.fish = {
        enable = true;

        interactiveShellInit =
          (builtins.readFile ./init.fish) + (builtins.readFile ./binds.fish);

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
    })

    (mkIf (cfg.enable && cfg.atuin) {
      programs.atuin = {
        enable = true;
        enableFishIntegration = false;
        settings = {
          dialect = "uk";
          auto_sync = false;
          update_check = false;
          sync_address = "";
          keymap_mode = "vim-insert";
          show_preview = true;
          show_help = false;
          enter_accept = false;
          show_tabs = false;
          style = "compact";
          filter_mode_shell_up_key_binding = "session";
        };
      };
    })

    (mkIf (cfg.enable && cfg.zoxide) {
      programs.zoxide = {
        enable = true;
        options = [ "--cmd cd" ];
      };
    })

    (mkIf (cfg.enable && cfg.crt) {
      home.packages = [
        pkgs.mypkgs.crt
      ];
    })

    (mkIf (cfg.enable && cfg.starship) {
      programs.starship = {
        enable = true;
        settings = {
          add_newline = false;
          command_timeout = 5000;
          format = concatStrings [
            "\${env_var.DISTROBOX_ENTER_PATH}"
            "$nix_shell"
            "$jobs"
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

          jobs = {
            symbol = "󰜎";
            format = "[$symbol]($style) ";
            disabled = false;
          };

          env_var.DISTROBOX_ENTER_PATH = {
            symbol = "  ";
            format = "[$symbol]($style)";
            style = "bold blue";
          };
        };
      };
    })
  ];
}
