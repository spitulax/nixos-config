{ pkgs
, ...
}: {
  services.tumbler.enable = true; # Thumbnail support for images
  environment.systemPackages = with pkgs; [
    # File preview
    webp-pixbuf-loader # .webp
    ffmpegthumbnailer # video
  ];
}
