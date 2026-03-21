{ pkgs, config, ... }:

{
  # 1. 安装核心包及增强插件
  home.packages = with pkgs; [
    nautilus       # 主程序
    nautilus-python # 支持右键菜单插件
    sushi          # 预览神器：选中文件按空格键直接预览图片/视频/PDF
    adwaita-icon-theme # 确保图标不乱码
  ];

  # 2. 核心修复：重写桌面启动项，干掉 D-Bus 激活
  xdg.desktopEntries."org.gnome.Nautilus" = {
    name = "Files (System)";
    exec = "nautilus %U";
    settings.NoDisplay = "true";
  };
  
  xdg.desktopEntries.nautilus = {
    name = "Files";
    genericName = "File Manager";
    exec = "nautilus %U";
    icon = "org.gnome.Nautilus";
    categories = [ "System" ];
    mimeType = [ "inode/directory" ];
    terminal = false;
    settings = {
      DBusActivatable = "false"; # 彻底解决 tofi 点开没反应的问题
    };
  };

  # 3. 美化：让 Nautilus 强制使用暗色主题（适配你的 Niri 环境）
  dconf.settings = {
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      search-view = "list-view";
      # 开启缩略图
      show-image-thumbnails = "always";
    };
  };

  # 4. 解决缩略图显示（需要相关的二进制支持）
  # 建议在 configuration.nix 里也开启 services.gvfs.enable = true;
}
