{ config, ... }:
{
  config.programs.nixvim = {
    highlightOverride = with config.lib.stylix.colors.withHashtag; {
      CursorLineNr = { bg = base01; fg = base06; };
      Comment.italic = true;
      Comment.fg = base03;
      Boolean.italic = true;
      Boolean.fg = base0E;
      String.italic = true;
      String.fg = base0B;
      StatusLine.bg = base00;
      Delimiter.bg = base01;
    };
    extraConfigLua = ''
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
          vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
        end,
      })
    '';
  };
}
