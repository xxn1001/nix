{ ... }:
{
  programs.lazygit = {
    enable = true;

    settings = {
      gui.border = "single";
    };
  };

  home.shellAliases = {
    gs = "git status";
    ga = "git add";
    gaa = "git add .";
    gc = "git commit -m";
    gp = "git push";
    gpl = "git pull";
    gl = "git log --oneline --graph --decorate";
    gd = "git diff";
    gsw = "git switch";
    gsc = "git switch -c";
    gco = "git checkout";
    gst = "git stash";
    gsp = "git stash pop";
  };
}
