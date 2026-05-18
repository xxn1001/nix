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
    zjd = "zellij delete-session";
    zjc = "zellij attach --create";
    zjda = "zellij delete-all-sessions";
    zjl = "zellij list-sessions";
    zjn = "zellij --layout default";
  };

  stylix.targets.zellij.enable = true;
}
