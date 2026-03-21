{
  pkgs,
  user,
  ...
}:
{
  imports = [
    ./boot.nix
  ];

  networking.networkmanager.enable = true;

  time = {
    timeZone = "Asia/Shanghai";
    hardwareClockInLocalTime = true;
  };

  i18n = {
    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  services = {
    displayManager.gdm.enable = false;

    # xserver = {
    #   enable = true;
    #   desktopManager.runXdgAutostartIfNone = true;
    #   xkb.layout = "us";
    #   xkb.variant = "";
    # };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    blueman.enable = true;

    gvfs.enable = true;
 
    openssh.enable = true;

    flatpak.enable = true;

    upower.enable = true;

    udisks2.enable = true;
  };

  security = {
    rtkit.enable = true;
    sudo.extraRules = [
      {
        users = [ user ];
        commands = [
          {
            command = "ALL";
          }
        ];
      }
    ];

    polkit.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  documentation.man.generateCaches = true;

  users.users.${user} = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Eden Lee";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "video"
      "kvm"
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      git
      gcc
      wget
      curl
      gnumake
      cmake
      ntfs3g
      base16-schemes
      home-manager
      polkit
      polkit_gnome
    ];

    variables = {
      EDITOR = "vim";
      GDK_SCALE = "";
      GDK_DPI_SCALE = "";
      # NIRI_CONFIG = "/home/${user}/.config/niri/config-override.kdl";
    };

    sessionVariables = {
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "ibus";
      QT_SCALE_FACTOR_ROUNDING_POLICY = "round";
      GSK_RENDERER = "vulkan";
      NIXOS_OZONE_WL = "1";
    };

    localBinInPath = true;
  };

  systemd.user.services = {
    polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    niri-flake-polkit.enable = false;
  };

  virtualisation = {
    libvirtd.enable = true;

    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers.backend = "podman";
  };
}
