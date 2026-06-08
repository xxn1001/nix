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
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "zen-beta.desktop";
    "x-scheme-handler/https" = "zen-beta.desktop";
    "x-scheme-handler/chrome" = "zen-beta.desktop";
    "text/html" = "zen-beta.desktop";
    "application/x-extension-htm" = "zen-beta.desktop";
    "application/x-extension-html" = "zen-beta.desktop";
    "application/x-extension-shtml" = "zen-beta.desktop";
    "application/xhtml+xml" = "zen-beta.desktop";
    "application/x-extension-xhtml" = "zen-beta.desktop";
    "application/x-extension-xht" = "zen-beta.desktop";
    "application/pdf" = "zen-beta.desktop";
  };

  # stylix.targets.zen.enable = true;
  # stylix.targets.firefox.enable = true;  
}
