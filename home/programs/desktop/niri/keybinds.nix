{ config, lib, user, ... }:
{
  programs.niri.settings = {
    binds = with config.lib.niri.actions;
    let mod = "Super";
    in
    {
      "${mod}+T".action = spawn "kitty";
      "${mod}+F".action = maximize-column;
      "${mod}+Alt+F".action = fullscreen-window;
      "${mod}+Q".action = close-window;
      "${mod}+Z".action = spawn "tofi-drun" "--drun-launch=true";
      "${mod}+X".action = spawn "/home/${user}/scripts/tofi/powermenu";
      "${mod}+Shift+W".action = spawn "/home/${user}/scripts/change-wal-niri";
      "${mod}+P".action = spawn [ "sh" "-c" "$(tofi-run)" ];
      "${mod}+Shift+C".action = spawn "/home/${user}/scripts/tofi/colorscheme";
    };
  };
}
