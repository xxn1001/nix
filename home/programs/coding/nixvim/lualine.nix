{ config, ... }:
let
  c = config.lib.stylix.colors;
in
{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = {
          normal = {
            a = { bg = c.base0D; fg = c.base00; };
            b = { bg = c.base01; fg = c.base05; };
            c = { bg = c.base00; fg = c.base04; };
          };
          insert = { a = { bg = c.base0B; fg = c.base00; }; b = { bg = c.base01; fg = c.base05; }; c = { bg = c.base00; }; };
          visual = { a = { bg = c.base0E; fg = c.base00; }; b = { bg = c.base01; fg = c.base05; }; c = { bg = c.base00; }; };
          replace = { a = { bg = c.base08; fg = c.base00; }; b = { bg = c.base01; fg = c.base05; }; c = { bg = c.base00; }; };
          command = { a = { bg = c.base0C; fg = c.base00; }; b = { bg = c.base01; fg = c.base05; }; c = { bg = c.base00; }; };
        };
        globalstatus = true;
        disabled_filetypes.statusline = [ "dashboard" "alpha" "starter" "snacks_dashboard" ];
      };
      sections = {
        lualine_a = [{ __unkeyed = "mode"; fmt = "string.lower"; }];
        lualine_b = [
          { __unkeyed = "branch"; icon.__unkeyed = ""; }
          { __unkeyed = "diff"; }
        ];
        lualine_c = [{
          __unkeyed = "diagnostics";
          symbols = { error = " "; warn = " "; info = " "; hint = "󰝶 "; };
        }];
        lualine_x = [{
          __unkeyed = "filetype";
          colored = true;
        }];
        lualine_y = [{
          __unkeyed = "filename";
          file_status = true;
          path = 1;
        }];
        lualine_z = [{ __unkeyed = "location"; }];
      };
    };
  };
}
