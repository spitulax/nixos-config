{ lib
, ...
}:
let
  defaults = {
    "nvim.desktop" = [
      "text/plain"
      "text/css"
      "text/csv"
      "text/html"
      "text/javascript"
      "application/json"
      "application/ld+json"
      "application/x-httpd-php"
      "application/x-sh"
      "application/xhtml+xml"
      "application/xml"
      "text/xml"
    ];
    "mpv.desktop" = [
      "audio/aac"
      "video/x-msvideo"
      "audio/midi"
      "audio/x-midi"
      "audio/mpeg"
      "video/mp4"
      "video/mpeg"
      "audio/ogg"
      "video/ogg"
      "application/ogg"
      "audio/ogg"
      "video/mp2t"
      "audio/wav"
      "audio/webm"
      "video/webm"
      "video/3gpp"
      "audio/3gpp"
      "video/3gpp2"
      "audio/3gpp2"
    ];
    "org.nomacs.ImageLounge.desktop" = [
      "image/apng"
      "image/avif"
      "image/bmp"
      "image/gif"
      "image/vnd.microsoft.icon"
      "image/jpeg"
      "image/png"
      "image/tiff"
      "image/webp"
    ];
    "org.pwmt.zathura.desktop" = [
      "application/pdf"
    ];
    "brave-browser.desktop" = [
      "image/svg+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
    "yazi.desktop" = [
      "inode/directory"
    ];
    # "?" = [
    #   "application/msword"
    #   "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    #   "application/vnd.ms-powerpoint"
    #   "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    #   "application/rtf"
    #   "application/vnd.ms-excel"
    #   "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    # ];
    # "?" = [
    #   "application/epub+zip"
    # ];
  };
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      lib.mergeAttrsList
        (lib.mapAttrsToList
          (_: v: v)
          (lib.mapAttrs
            (n: v: lib.genAttrs v (_: n))
            defaults))
    ;
  };
}
