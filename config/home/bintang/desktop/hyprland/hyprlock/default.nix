{ outputs
, ...
}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        no_fade_in = true;
      };
      background = {
        monitor = "";
        path = "${outputs.vars.assetsPath}/wallpapers/hyprland.png";
        color = "rgba(137, 180, 250, 1.0)";
      };
      input-field = {
        monitor = "";
        size = "200, 50";
        outline_thickness = 3;
        outer_color = "rgb(49, 50, 68)";
        inner_color = "rgb(108, 112, 134)";
        font_color = "rgb(30, 30, 46)";
        placeholder_text = "";
        check_color = "rgb(205, 214, 244)";
        fail_color = "rgb(243, 139, 168)";
        fade_on_empty = false;
        position = "0, -200";
        halign = "center";
        valign = "center";
      };
      label = [
        {
          monitor = "";
          text = "Hi, $DESC <i>:3</i>";
          color = "rgb(205, 214, 244)";
          font_size = 25;
          font_family = "sans-serif";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "$TIME";
          color = "rgb(205, 214, 244)";
          font_size = 50;
          font_family = "sans-serif";
          position = "0, 500";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
