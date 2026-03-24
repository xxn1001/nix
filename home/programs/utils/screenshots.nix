{ pkgs, config, ... }:

let
  # 1. 定义截图脚本：集成 slurp 的白色蒙版、grim 抓取和 swappy 编辑
  screenshot-tool = pkgs.writeShellScriptBin "screenshot" ''
    # 设置保存目录（如果不存在则创建）
    SAVE_DIR="$HOME/Pictures/Screenshots"
    mkdir -p "$SAVE_DIR"

    # 使用 slurp 选择区域，设置白色半透明背景 (-b) 和白色边框 (-c)
    # -b #ffffff44: 25% 透明度的白色蒙版
    # -c #ffffffff: 纯白边框
    REGION=$(${pkgs.slurp}/bin/slurp -b "#ffffff44" -c "#ffffffff" -s "#00000000")

    # 如果用户按 ESC 取消，则退出
    [ -z "$REGION" ] && exit 0

    # 截图并发送给 swappy 进行标注
    # 在 swappy 中：点击保存会存入下面配置的目录，Ctrl+C 会存入剪贴板
    ${pkgs.grim}/bin/grim -g "$REGION" - | ${pkgs.swappy}/bin/swappy -f -
  '';
in
{
  # 2. 安装必要的软件包
  home.packages = with pkgs; [
    grim          # 截图核心
    slurp         # 选区工具
    swappy        # 编辑标注
    wl-clipboard  # 剪贴板支持
    screenshot-tool
  ];

  # 3. 写入 Swappy 配置文件（解决你提到的保存路径等细节）
  xdg.configFile."swappy/config".text = ''
    [Default]
    save_dir=$HOME/Pictures/Screenshots
    save_filename_format=screenshot_%Y%m%d_%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    og_size=20
  '';
}
