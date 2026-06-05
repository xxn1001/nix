{ pkgs, config, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "everforest_transparent";
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
        };
        lsp.display-inlay-hints = true;
      };
    };
    themes = {
      everforest_transparent = {
        inherits = "everforest_dark";
        "ui.background" = {
          bg = "none";
        };
        "ui.virtual.whitespace" = {
          fg = "none";
        };
        "ui.menu" = {
          bg = "none";
        };
        "ui.statusline" = {
          bg = "none";
        };
        "ui.popup" = {
          bg = "none";
        };
        "ui.window" = {
          bg = "none";
        };
      };
    };
  };
}
