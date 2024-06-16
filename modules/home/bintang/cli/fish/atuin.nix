{
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
}
