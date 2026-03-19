{ inputs, pkgs, ... }:
{
  boot = {
    # 1. 启用 Linux Zen 内核
    # Zen 内核针对桌面响应速度、游戏和多任务进行了调度优化
    kernelPackages = pkgs.linuxPackages_zen;

    loader = {
      # 2. 使用 systemd-boot 替代 GRUB
      systemd-boot.enable = true;
      # 限制保留的启动项数量，防止 /boot 分区被旧内核塞满
      systemd-boot.configurationLimit = 10;
      
      # 3. 物理机必须开启，允许 NixOS 修改 UEFI 启动顺序
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";

      # 4. 彻底关闭 GRUB 相关配置
      grub.enable = false;
    };

    # 5. 内核参数优化
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [ 
      "loglevel=3" 
      "quiet" 
      "splash" 
      "console=tty1"
      # 如果你是 NVMe 硬盘，可以加上下面这个优化
      "nvme_load=YES"
    ];
    
    # 6. 启用 Plymouth 开机动画（物理机观感更好）
    plymouth.enable = true;
  };
}
