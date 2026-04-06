{ config, lib, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:6:0:0";
    };
  };
  # boot.initrd.kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" ];
  # powerManagement.cpuFreqGovernor = "powersave";
  # services.tlp.enable = true;
  # services.tlp.settings = {
  #   # CPU_ENERGY_PERF_POLICY_ON_AC = "power";
  #   # CPU_MAX_PERF_ON_AC = 60;
  #   CPU_BOOST_ON_AC = 1;
  #   # CPU_BOOST_ON_BAT = 0;
  # };
  boot.kernelParams = [
    "video=eDP-2:d"
    "video=DP-2:d"

    # "nvidia-drm.modeset=1"

    "tsc=reliable"
    "clocksource=tsc"

    # "vfio-pci.ids=1002.164e"
    # "amd_iommu=on"
    # "iommu=pt"
    # "modprobe.blacklist=amdgpu"
    # "video=efifb:off"
  ];

  # boot.extraModprobeConfig = ''
  #   softdep amdgpu pre: vfio-pci
  #   options vfio-pci ids=1002:164e
  # '';
  # boot.blacklistedKernelModules = [ "amdgpu" "radeon" ];
}
  
