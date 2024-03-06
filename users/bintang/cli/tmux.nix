{ config
, lib
, pkgs
, ...
}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    clock24 = true;
    sensibleOnTop = true;
    shortcut = "space";
    baseIndex = 1;
    shell = "${pkgs.fish}/bin/fish";
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      yank
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour "mocha"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_window_default_fill "all"
          set -g @catppuccin_window_current_fill "all"
          set -g @catppuccin_window_middle_separator ":"
          set -g @catppuccin_window_status_enable "yes"
          set -g @catppuccin_window_status_icon_enable "no"
          set -g @catppuccin_status_modules "date_time session"
          set -g @catppuccin_date_time_text "%d/%m/%Y %H:%M:%S"
        '';
      }
    ];
    extraConfig = ''
      set -sg escape-time 10
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g renumber-windows on
      set -g status-interval 1

      bind -n M-H previous-window
      bind -n M-L next-window

      bind '"' split-window -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    '';
  };
}
