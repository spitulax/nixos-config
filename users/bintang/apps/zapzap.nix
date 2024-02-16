{ config
, pkgs
, ...
}: {
  home.packages = [ pkgs.zapzap ];
  home.file.".config/ZapZap/ZapZap.conf".text = ''
    [main]
    geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\a\x7f\0\0\x4\v\0\0\0\xee\0\0\0\xb7\0\0\x5\xed\0\0\x3\x44\0\0\0\0\x2\0\0\0\a\x80\0\0\0\0\0\0\0$\0\0\a\x7f\0\0\x4\v)
    windowState=@ByteArray(\0\0\0\xff\0\0\0\0\xfd\0\0\0\0\0\0\a\x80\0\0\x3\xe8\0\0\0\x4\0\0\0\x4\0\0\0\b\0\0\0\b\xfc\0\0\0\0)

    [notification]
    app=true

    [system]
    donation_message=false
    hide_bar_users=true
    keep_background=true
    spellCheckers=false
    start_system=true
    wayland=true
  '';
}
