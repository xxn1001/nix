{
  manager = {
    keymap = [
      # Git
      { on = [ "g" "s" ]; run = "plugin git"; desc = "Git file status"; }
      { on = [ "g" "b" ]; run = "plugin git --branch"; desc = "Git branches"; }
      { on = [ "g" "d" ]; run = "plugin diff"; desc = "Diff with hovered"; }

      # Navigation
      { on = [ "f" ]; run = "plugin jump-to-char"; desc = "Jump to character"; }

      # Bookmarks
      { on = [ "m" ]; run = "plugin bookmarks save"; desc = "Save bookmark"; }
      { on = [ "'" ]; run = "plugin bookmarks jump"; desc = "Jump to bookmark"; }

      # File operations
      { on = [ "C" ]; run = "plugin compress"; desc = "Compress selected"; }
      { on = [ "D" ]; run = "plugin recycle-bin"; desc = "Move to trash"; }

      # Misc
      { on = [ "<C-s>" ]; run = "shell \"$SHELL\" --block --confirm"; desc = "Open shell here"; }
    ];
  };
}
