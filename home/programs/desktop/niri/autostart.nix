{
  pkgs,
  ...
}:
let
  niri-autostart = pkgs.writeShellApplication {
    name = "niri-autostart";
    runtimeInputs = with pkgs; [
      wlsunset
    ];
    text = ''
      dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
      sleep 0.5 &
      wlsunset -l 39.9 -L 116.4 -t 5000 -T 6500 &
      wl-paste --type text --watch cliphist store &
      wl-paste --type image --watch cliphist store &
      sleep 0.2
    '';
  };
in
{
  programs.niri.settings.spawn-at-startup = [
    { command = [ "${niri-autostart}/bin/niri-autostart" ]; }
    { command = [ "${pkgs.xwayland-satellite}/bin/xwayland-satellite" ]; }
  ];
}
