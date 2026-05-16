{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;

    settings = {
      default_mode = "normal";
      pane_frames = false;
      mouse_mode = true;
      show_startup_tips = false;
    };

  };

  home.shellAliases = {
    zj = "zellij attach --create default";
    zjn = "zellij --layout default";
  };

  stylix.targets.zellij.enable = true;
}
