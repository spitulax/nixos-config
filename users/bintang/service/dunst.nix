{ pkgs
, lib
, config
, ...
}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        offset = 1;
        notification_limit = 10;
        history_length = 50;
        icon_corner_radius = 12;
        dmenu = "${pkgs.rofi-wayland}/bin/rofi -dmenu -p dunst";
        browser = "/usr/bin/env xdg-open";
        frame_width = 1;
        gap_size = 1;
        transparency = 20;
        frame_color = "#7f849c";
        sort = "update";
        font = "${config.fontProfile.sansSerif} 12";
        format = "<i><b>%a</b></i> ⋅ <b>%s</b>\\n<small>%b %p</small>";
        show_age_threshold = 30;
        sticky_history = false;
        corner_radius = 12;
        mouse_left_click = "do_action, open_url";
        mouse_middle_click = "context";
        mouse_right_click = "close_current";
        layer = "top";
        fullscreen = "delay";
        timeout = 10;
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
        layer = "overlay";
        timeout = 0;
      };
    };
  };
}
