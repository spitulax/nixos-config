let
  # TODO: add global colorscheme that all modules can use
  colors = {
    bg0 = "#101020";
    bg1 = "#313244";
    overlay0 = "#6c7086";
    text = "#cdd6f4";
    red = "#f38ba8";
    blue = "#89b4fa";
    yellow = "#f9e2af";
  };
in
{
  programs.zathura = {
    enable = true;
    mappings = {
      "h" = "navigate previous";
      "l" = "navigate next";
      "<C-h>" = "navigate left";
      "<C-l>" = "navigate right";
    };
    options = with colors; {
      completion-bg = bg1;
      completion-fg = text;
      completion-group-bg = bg0;
      completion-group-fg = text;
      completion-highlight-bg = overlay0;
      completion-highlight-fg = text;
      default-bg = bg0;
      default-fg = text;
      font = "monospace normal 10";
      guioptions = "sc";
      inputbar-bg = bg0;
      inputbar-fg = text;
      notification-bg = blue;
      notification-fg = bg0;
      notification-error-bg = red;
      notification-error-fg = bg0;
      notification-warning-bg = yellow;
      notification-warning-fg = bg0;
      statusbar-fg = text;
      statusbar-bg = bg1;
      highlight-active-color = blue;
      highlight-color = blue;
      highlight-fg = blue;
      index-active-bg = yellow;
      index-active-fg = bg0;
      index-bg = bg1;
      index-fg = text;
      page-padding = 3;
      pages-per-row = 2;
      advance-pages-per-row = true;
      scroll-page-aware = true;
      show-hidden = true;
      statusbar-home-tilde = true;
      statusbar-page-percent = true;
      window-title-basename = true;
      window-title-home-tilde = true;
      window-width = 1280;
      window-height = 720;
    };
  };
}
