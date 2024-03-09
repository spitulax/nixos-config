{ config
, pkgs
, ...
}: {
  services.mako = {
    enable = true;
    extraConfig = ''
      max-history=50
      on-button-left=exec makoctl menu -n "$id" ${pkgs.rofi-wayland}/bin/rofi -dmenu -p 'Select action'
      on-button-middle=dismiss-all
      on-button-right=dismiss
      on-notify=exec mpv /run/current-system/sw/share/sounds/freedesktop/stereo/message.oga
      font=sans-serif 12
      background-color=#101020
      border-color=#7f849c
      border-radius=12
      progress-color=over #585b70
      format=<i><b>%a</b></i> ⋅ <b>%s</b>\n<small>%b</small>
      default-timeout=5000
      ignore-timeout=1
      max-visible=10
      max-icon-size=32
      width=400
      height=200

      [urgency=low]
      text-color=#6c7086

      [urgency=normal]
      text-color=#cdd6f4

      [urgency=high]
      text-color=#f38ba8
      layer=overlay
      default-timeout=0

      [grouped]
      format=(%g) <i><b>%a</b></i> ⋅ <b>%s</b>\n<small>%b</small>

      [hidden]
      format=%h notification(s) hidden

      [mode=do-not-disturb]
      invisible=1
    '';
  };
}
