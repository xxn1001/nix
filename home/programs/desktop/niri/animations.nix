{ config, ... }:
{
  programs.niri.settings.animations = {
    # 窗口打开：简单的物理弹簧，去掉 shader
    window-open = {
      kind.spring = {
        damping-ratio = 0.7;
        stiffness = 300;
        epsilon = 0.001;
      };
    };

    # 窗口关闭：缩短时间，去掉燃烧特效
    window-close = {
      kind.easing = {
        curve = "ease-out-quad";
        duration-ms = 150; # 从 1000ms 缩短到 150ms，干脆利落
      };
    };

    # 窗口缩放：使用原生逻辑，不拉伸不闪烁
    window-resize = {};

    # 工作区和移动：保持高硬度，极速响应
    workspace-switch = {
      kind.spring = {
        damping-ratio = 0.8;
        stiffness = 600;
        epsilon = 0.001;
      };
    };

    horizontal-view-movement = {
      kind.spring = {
        damping-ratio = 1.0;
        stiffness = 600;
        epsilon = 0.001;
      };
    };

    window-movement = {
      kind.spring = {
        damping-ratio = 1.0;
        stiffness = 600;
        epsilon = 0.001;
      };
    };
  };
}
