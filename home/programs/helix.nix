{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "blur_theme";
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
        };
      };
    };

    themes = {
      blur_theme = {
        inherits = "gruvbox";
        "ui.background" = { bg = "none"; };
        "ui.virtual.whitespace" = { fg = "none"; };
        "ui.menu" = { bg = "none"; };
      };
    };
  };
}
