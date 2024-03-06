{ pkgs
, lib
, config
, ...
}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # offset = n;
        notification_limit = 10;
        icon_corner_radius = 12;
        dmenu = "${pkgs.rofi-wayland}/bin/rofi -dmenu -p dunst";
        browser = "/usr/bin/env xdg-open";
        frame_width = 1;
        gap_size = 1;
        transparency = 20;
        frame_color = "#7f849c";
        sort = "update";
        font = "${config.fontProfile.sansSerif} 10";
        format = "<i><b>%a</b></i> ⋅ <b>%s</b>\\n<small>%b %p</small>";
        show_age_threshold = 30;
        sticky_history = false;
        history_length = 50;
        corner_radius = 12;
        mouse_left_click = "do_action, open_url";
        mouse_middle_click = "context";
        mouse_right_click = "close_current";
        fullscreen = "delay";
        timeout = 5;
      };
      urgency_low = {
        background = "#101020";
        foreground = "#6c7086";
      };
      urgency_normal = {
        background = "#101020";
        foreground = "#cdd6f4";
      };
      urgency_critical = {
        background = "#101020";
        foreground = "#f38ba8";
        layer = "top";
        fullscreen = "show";
        timeout = 0;
      };
    };
  };
}
