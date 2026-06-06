{
  programs.nixvim = {
    plugins.nvim-ufo = {
      enable = true;
      setupLspCapabilities = true;
      settings = {
        fold_virt_text_handler = ''
          function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (" 󰁂 %d "):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
              local chunkText = chunk[1]
              local chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
              else
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, { chunkText, hlGroup })
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if curWidth + chunkWidth < targetWidth then
                  suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                end
                break
              end
              curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, "Comment" })
            return newVirtText
          end
        '';
        provider_selector = ''
          function(bufnr, filetype, buftype)
            return { "treesitter", "indent" }
          end
        '';
        preview.mappings = {
          scrollU = "<C-u>";
          scrollD = "<C-d>";
          jumpTop = "[";
          jumpBot = "]";
        };
      };
    };
    keymaps = [
      {
        key = "zR";
        action.__raw = "function() require('ufo').openAllFolds() end";
        options = { silent = true; desc = "打开全部折叠"; };
        mode = "n";
      }
      {
        key = "zM";
        action.__raw = "function() require('ufo').closeAllFolds() end";
        options = { silent = true; desc = "折叠全部代码"; };
        mode = "n";
      }
      {
        key = "K";
        action.__raw = ''
          function()
            local winid = require("ufo").peekFoldedLinesUnderCursor()
            if not winid then
              vim.lsp.buf.hover()
            end
          end
        '';
        options = { silent = true; desc = "查看折叠/悬浮文档"; };
        mode = "n";
      }
    ];
  };
}
