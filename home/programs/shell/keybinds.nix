{ config, lib, ... }:
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
      "${mod}+D".action = spawn "fuzzel";
    };
  };
}
