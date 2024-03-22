{ config
, ...
}: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = "nvim.desktop";
      "inode/directory" = "org.kde.dolphin.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "application/pdf" = "org.pwmt.zathura.desktop";
      "image/png" = "nomacs.desktop";
      "image/jpeg" = "nomacs.desktop";
      "video/ogg" = "mpv.desktop";
      "video/x-msvideo" = "mpv.desktop";
      "audio/mpeg" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/x-flv" = "mpv.desktop";
      "video/mp4" = "mpv.desktop";
      "audio/x-flac" = "mpv.desktop";
      "audio/mp4" = "mpv.desktop";
    };
  };
}
