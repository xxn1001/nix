{
  pkgs,
  lib,
  user,
  config,
  ...
}:
let
  niri-autostart = pkgs.writeShellApplication {
    name = "niri-autostart";
    runtimeInputs = with pkgs; [
      awww
      wlsunset
      systemd
      killall
      waycorner
    ];
    extraShellCheckFlags = [ ];
    bashOptions = [ ];
    text =
      # bash
      ''
        dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
        sleep 0.5 &
        awww kill
        awww-daemon --namespace "background" &
        awww-daemon --namespace "backdrop" &
        # awww restore --namespace "background"
        # awww restore --namespace "backdrop"
        wlsunset -l 39.9 -L 116.4 -t 5000 -T 6500 &
        sleep 0.2
      ''
      + (
        builtins.attrNames config.monitors
        |> map (monitor: [
          "awww img --namespace background -o ${monitor} \"/home/${user}/Pictures/Wallpapers/generated/$(cat ~/Pictures/Wallpapers/${monitor}-file)\""
          "sleep 0.2"
          "awww img --namespace backdrop -o ${monitor} \"/home/${user}/Pictures/Wallpapers/generated/$(cat ~/Pictures/Wallpapers/${monitor}-blurred-file)\""
          "sleep 0.2"
        ])
        |> builtins.concatLists
        |> builtins.concatStringsSep "\n"
      )
      + "\n";
      # + (
      #   if config.desktopShell == "caelestia" then
      #     # bash
      #     ''
      #       caelestia wallpaper -f "/home/${user}/Pictures/Wallpapers/generated/$(cat ~/Pictures/Wallpapers/${config.lib.monitors.mainMonitorName}-file)"
      #       caelestia scheme set -n dynamic -m dark
      #     ''
      #   else
      #     ""
      # );
  };
in
{
  programs.niri.settings.spawn-at-startup = [
    { command = [ "${niri-autostart}/bin/niri-autostart" ]; }
    { command = [ "${pkgs.xwayland-satellite}/bin/xwayland-satellite" ]; }
  ];
}
