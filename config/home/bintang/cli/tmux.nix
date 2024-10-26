{ config
, lib
, pkgs
, ...
}: {
  options.configs.cli.tmux.enable = lib.mkEnableOption "tmux" // {
    default = true;
  };

  config = lib.mkIf config.configs.cli.tmux.enable {
    programs.tmux = {
      enable = true;
      keyMode = "vi";
      mouse = true;
      clock24 = true;
      sensibleOnTop = true;
      shortcut = "space";
      baseIndex = 1;
      shell = lib.getExe config.configs.defaultShell;
      # TODO: global theming
      plugins = with pkgs.tmuxPlugins; [
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
            set -g @catppuccin_date_time_text "%d/%m/%Y %H:%M"
          '';
        }
      ];
      extraConfig = ''
        set -sg escape-time 10
        set -g default-terminal "tmux-256color"
        set-option -sa terminal-overrides ",xterm*:Tc"
        set -g renumber-windows on
        set -g status-interval 1

        bind -n M-H previous-window
        bind -n M-L next-window
        bind C-l send-keys 'C-l'
        bind C-k kill-session

        bind '"' split-window -c "#{pane_current_path}"
        bind '%' split-window -h -c "#{pane_current_path}"

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        # https://github.com/christoomey/vim-tmux-navigator
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
        bind-key -n 'C-\' if-shell "$is_vim" 'send-keys C-\\'  'select-pane -l'

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        bind-key -T copy-mode-vi 'C-\' select-pane -l
      '';
    };
  };
}
