{ pkgs
, ...
}: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      thunar-media-tags-plugin
    ];
  };
  programs.xfconf.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  environment.systemPackages = with pkgs; [
    # File preview
    webp-pixbuf-loader # .webp
    ffmpegthumbnailer # video
  ];
}
