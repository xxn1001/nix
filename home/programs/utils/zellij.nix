{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;

    settings = {
      default_mode = "normal";
      pane_frames = false;
      mouse_mode = true;
    };

    layouts = {
      default = ''
        layout {
          pane size=1 borderless=true {
            plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
              // 🎨 拒绝硬编码！全部使用标准 Base16 颜色变量
              // {base0D} 通常是主题里的激活主色（如蓝色/紫色），{base01} 是次级背景
              format_left  "{mode} #[fg=base0D,bold]{session} {tabs}"
              format_right "{command_git_branch} #[fg=base0D,bold]{datetime}"
              format_space ""

              border_enabled  "false"
              border_click     "false"

              // 自动适配：所有状态灯的颜色都会随着你 Stylix 的更换而完美变色
              mode_normal        "#[bg=base0D,fg=base00,bold] NORMAL "
              mode_locked        "#[bg=base08,fg=base00,bold] LOCKED "  // base08 通常是警示红
              mode_resize        "#[bg=base09,fg=base00,bold] RESIZE "  // base09 通常是橙色
              mode_pane          "#[bg=base0B,fg=base00,bold] PANE "    // base0B 通常是复苏绿
              mode_tab           "#[bg=base0E,fg=base00,bold] TAB "     // base0E 通常是优雅紫
              mode_scroll        "#[bg=base0A,fg=base00,bold] SCROLL "  // base0A 通常是警告黄
              mode_enter_search  "#[bg=base0D,fg=base00,bold] ENT-SEARCH "
              mode_search        "#[bg=base0D,fg=base00,bold] SEARCH "
              mode_rename_pane   "#[bg=base0B,fg=base00,bold] RENAME-PANE "
              mode_rename_tab    "#[bg=base0E,fg=base00,bold] RENAME-TAB "
              mode_session       "#[bg=base0C,fg=base00,bold] SESSION " // base0C 通常是青色/青翠蓝
              mode_move          "#[bg=base0F,fg=base00,bold] MOVE "
              mode_tmux          "#[bg=base09,fg=base00,bold] TMUX "

              // 未选中的标签页用暗色（base03/04），激活的用明亮色
              tab_normal   "#[fg=base04] {name} "
              tab_active   "#[fg=base0B,bold,italic] {name} "

              // Git 状态侦听
              command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
              command_git_branch_format      "#[fg=base04]git:#[fg=base0E,bold] {stdout} "
              command_git_branch_interval    "10"
              command_git_branch_rendermode  "static"

              // 时间与时区
              datetime        "#[fg=base04] {format} "
              datetime_format "%A, %d %b %Y %H:%M"
              datetime_timezone "Asia/Shanghai"
            }
          }
          pane
        }
      '';
    };
  };

  home.shellAliases = {
    zj = "zellij attach --create default";
    zjn = "zellij --layout default";
  };

  stylix.targets.zellij.enable = true;
}
