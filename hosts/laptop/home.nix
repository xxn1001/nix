{ pkgs, ... }:
{
  monitors = {
    "eDP-1" = {
      isMain = true;
      scale = 1.6;        # 建议设为 1.6，这样 2.5K 屏幕下的图标和文字大小最适中
      mode = {
        width = 2560;     # R9000P 2023 物理宽度
        height = 1600;    # R9000P 2023 物理高度
        refresh = 240.0;  # 你的满血刷新率
      };
      position = {
        x = 0;
        y = 0;
      };
      rotation = 0;
      focus-at-startup = true;
    };
  };

  # 保持 stateVersion 一致（除非你之前改过）
  home.stateVersion = "23.11";
  stylix.cursor = {
    package = pkgs.hei-cursors;
    name = "hei";
    size = 48;
  };
  programs.niri.settings = {
    cursor = {
      theme = "hei";
      size = 48;
    };
  };
}
