{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.configs.desktop.hyprland.enable {
    services.mako = {
      enable = true;
      extraConfig = ''
        max-history=50
        on-button-left=exec makoctl menu -n "$id" ${pkgs.rofi-wayland}/bin/rofi -dmenu -p 'Select action'
        on-button-middle=dismiss-all
        on-button-right=dismiss
        on-notify=exec mpv /run/current-system/sw/share/sounds/freedesktop/stereo/message.oga
        font=sans-serif 12
        background-color=#313244CC
        border-color=#6c7086CC
        border-radius=12
        progress-color=over #585b70CC
        format=<i><b>%a</b></i> ⋅ <b>%s</b>\n<small>%b</small>
        default-timeout=5000
        ignore-timeout=1
        max-visible=10
        max-icon-size=32
        width=400
        height=200

        [urgency=low]
        text-color=#6c7086
        background-color=#101020CC
        on-notify=none

        [urgency=normal]
        text-color=#cdd6f4

        [urgency=critical]
        text-color=#f38ba8
        layer=overlay
        default-timeout=0

        [urgency=critical body~="^www\.youtube\.com"]
        text-color=#cdd6f4
        layer=top
        default-timeout=5000

        [grouped]
        format=(%g) <i><b>%a</b></i> ⋅ <b>%s</b>\n<small>%b</small>

        [hidden]
        format=%h notification(s) hidden

        [mode=do-not-disturb]
        invisible=1
        on-notify=none

        [mode=do-not-disturb urgency=critical]
        invisible=0

        [app-name=popup]
        invisible=0
        layer=overlay
        width=150
        height=150
        anchor=top-center
        default-timeout=1000
        text-alignment=center
        on-button-left=none
        on-button-middle=none
        on-button-right=none
        on-notify=none
        ignore-timeout=0
        format=<b>%s\n%b</b>
      '';
    };
  };
}
