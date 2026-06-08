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

  xdg.mimeApps = {
    enable = true;
    defaultApplicationPackages = [ pkgs.thunar ];
  };

  xdg.desktopEntries.thunar = {
    name = "Files";
    genericName = "File Manager";
    exec = "thunar %U";
    icon = "org.xfce.thunar";
    categories = ["System" "FileManager"];
    terminal = false;
  };
}
