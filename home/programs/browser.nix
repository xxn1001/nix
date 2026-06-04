{ pkgs, inputs, ... }:
{
  programs.zen-browser = {
    enable = true;

    # 配置 Profile (就像 Firefox 一样)
    profiles.default = {
      isDefault = true;
      
      # 自动修改 about:config 设置
      settings = {
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "ui.systemUsesDarkTheme" = 0;
        "layout.css.prefers-color-scheme.content" = 0;
      };
    };
  };
  # stylix.targets.zen.enable = true;
  # stylix.targets.firefox.enable = true;  
}
