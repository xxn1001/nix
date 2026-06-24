{
  config,
  pkgs,
  user,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = user;
        command = "${config.programs.niri.package}/bin/niri-session";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
