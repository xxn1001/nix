{ pkgs, config, ... }:

let
  # 1. 引用外部脚本文件并注入依赖
  # 使用 substiteAll 或 simple strings 替换可以确保脚本内部调用的命令指向 Nix Store
  niri-blur-bin = pkgs.writeShellScriptBin "niri-auto-blur" ''
    # 注入必要的工具到 PATH，防止 NixOS 找不到命令
    export PATH="${pkgs.lib.makeBinPath [
      pkgs.niri
      pkgs.jq
      pkgs.imagemagick
      pkgs.swww
      pkgs.findutils
      pkgs.coreutils
      pkgs.gnugrep
    ]}:$PATH"

    # 读取并执行外部脚本文件
    ${builtins.readFile ./niri_auto_blur_bg.sh}
  '';
in
{
  # 2. 将包装后的脚本加入用户安装列表
  home.packages = [ niri-blur-bin ];

  # 3. 配置 systemd 用户服务实现开机自启
  systemd.user.services.niri-auto-blur = {
    Unit = {
      Description = "Niri 自动壁纸模糊守护进程";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      # 使用 Nix 生成的二进制路径
      ExecStart = "${niri-blur-bin}/bin/niri-auto-blur";
      Restart = "on-failure";
      RestartSec = 3;
      # 考虑到你对 root 权限的严格管理，这里作为 user service 运行非常安全
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
