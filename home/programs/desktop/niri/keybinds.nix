{
  config,
  user,
  ...
}:
{
  programs.niri.settings = {
    binds =
      with config.lib.niri.actions;
      let
        mod = "Super";
      in
      {
        "${mod}+T".action = spawn "kitty";
        "${mod}+F".action = maximize-column;
        "${mod}+Alt+F".action = fullscreen-window;
        "${mod}+Q".action = close-window;
        "${mod}+Shift+Q".action = spawn "/home/${user}/scripts/niri-force-kill-window";
        "${mod}+Z".action = spawn "tofi-drun" "--drun-launch=true";
        "${mod}+X".action = spawn "/home/${user}/scripts/tofi/powermenu";
        "${mod}+Shift+S".action = spawn "screenshot";
        "${mod}+V".action = spawn [
          "sh"
          "-c"
          "cliphist list | tofi | cliphist decode | wl-copy"
        ];
        "${mod}+Shift+R".action = spawn "wl-color-picker";
        "${mod}+H".action = focus-column-left;
        "${mod}+L".action = focus-column-right;
        "${mod}+Ctrl+H".action = move-column-left;
        "${mod}+Ctrl+L".action = move-column-right;
        "${mod}+Ctrl+K".action = move-window-up;
        "${mod}+Ctrl+J".action = move-window-down;
        "${mod}+K".action = focus-window-up;
        "${mod}+J".action = focus-window-down;
        "${mod}+Y".action = focus-workspace-up;
        "${mod}+N".action = focus-workspace-down;
        "${mod}+Ctrl+Y".action = move-window-to-workspace-up;
        "${mod}+Ctrl+N".action = move-window-to-workspace-down;
        "${mod}+R".action = switch-preset-column-width; # 极为好用！在默认、预设宽度间循环
      };
  };
}
