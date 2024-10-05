{ config
, lib
, myLib
, ...
}:
let
  inherit (lib)
    mkOption
    types
    mergeAttrsList
    mapAttrs
    attrValues
    genAttrs
    mapAttrsToList
    ;
  inherit (myLib)
    stripAttrs
    ;

  cfg = config.configs.apps.mime;

  mimeGroup = {
    text = [
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
    audio = [
      "audio/aac"
      "audio/midi"
      "audio/x-midi"
      "audio/mpeg"
      "audio/ogg"
      "application/ogg"
      "audio/wav"
      "audio/webm"
      "audio/3gpp"
      "audio/3gpp2"
    ];
    video = [
      "video/x-msvideo"
      "video/mp4"
      "video/mpeg"
      "video/ogg"
      "video/mp2t"
      "video/webm"
      "video/3gpp"
      "video/3gpp2"
    ];
    image = [
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
    pdf = [
      "application/pdf"
    ];
    vector = [
      "image/svg+xml"
    ];
    web = [
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
    directory = [
      "inode/directory"
    ];
    epub = [
      "application/epub+zip"
    ];
    wordDoc = [
      "application/msword"
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      "application/rtf"
    ];
    slideshowDoc = [
      "application/vnd.ms-powerpoint"
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    ];
    spreadsheetDoc = [
      "application/vnd.ms-excel"
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ];
  };
in
{
  options.configs.apps.mime =
    mapAttrs
      (k: v:
        mkOption {
          type = types.nullOr (types.oneOf [
            types.str
            (types.submodule {
              options = {
                entry = mkOption {
                  type = types.nullOr types.str;
                  default = null;
                  description = "Desktop entry to open ${k} files.";
                };
                packages = mkOption {
                  type = types.listOf types.package;
                  default = [ ];
                  description = "Extra packages to install to be able to open with `entry`.";
                };
              };
            })
          ]);
          default = null;
          description = "Desktop entry to open ${k} files.";
        })
      mimeGroup;

  config = {
    xdg.mimeApps = {
      enable = true;
      defaultApplications =
        mergeAttrsList
          (attrValues
            (mapAttrs
              (k: v: genAttrs mimeGroup.${k} (_: v))
              (mapAttrs
                (_: v: if builtins.isAttrs v then v.entry else v)
                (stripAttrs cfg))))
      ;
    };

    home.packages =
      builtins.concatLists
        (mapAttrsToList
          (_: v: if builtins.isAttrs v then v.packages else [ ])
          cfg);
  };
}
