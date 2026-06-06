{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    thunar
    thunar-archive-plugin
    thunar-volman
    thunar-media-tags-plugin
    xfconf
    tumbler
    ffmpegthumbnailer
    poppler-utils
  ];

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "thunar.desktop";
  };

  xdg.desktopEntries.thunar = {
    name = "Files";
    genericName = "File Manager";
    exec = "thunar %U";
    icon = "org.xfce.thunar";
    categories = ["System" "FileManager"];
    mimeType = ["inode/directory"];
    terminal = false;
  };
}
