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
    # prime = {
    #   offload = {
    #     sync.enable = true;
    #   };
    #   nvidiaBusId = "PCI:1:0:0";
    #   amdgpuBusId = "PCI:6:0:0";
    # };
  };
  # boot.initrd.kernelModules = [ "amdgpu" ];
  # powerManagement.cpuFreqGovernor = "powersave";
  services.tlp.enable = true;
  services.tlp.settings = {
    CPU_ENERGY_PERF_POLICY_ON_AC = "power";
    CPU_MAX_PERF_ON_AC = 60;
    CPU_BOOST_ON_AC = 1;
    # CPU_BOOST_ON_BAT = 0;
  };
  boot.kernelParams = [ "video=eDP-2:d" ];
}
  
