{ config, pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        # 关联你的 Kitty 终端
        terminal = "${pkgs.kitty}/bin/kitty";
        
        layer = "overlay";
        width = 30;
        lines = 10;
        
        # 不写死具体字体，让它跟随系统 fontconfig 的 monospace 设置
        # 如果你想手动指定大小但跟随系统字体族，可以写 "monospace:size=12"
        font = "monospace:size=12"; 
        
        horizontal-pad = 20;
        vertical-pad = 15;
        inner-pad = 10;
      };

      colors = {
        # 匹配现代暗色主题，带透明度以适应 Niri 的视觉风格
        background = "1e1e2edd"; 
        text = "cdd6f4ff";
        match = "f38ba8ff";
        selection = "585b70ff";
        selection-text = "f8f8f2ff";
        border = "b4befeff";
      };

      border = {
        width = 2;
        radius = 10;
      };
    };
  };

  # 建议确保系统有一个基础图标库，否则 Fuzzel 界面会比较单调
  home.packages = [ pkgs.papirus-icon-theme ];
}
