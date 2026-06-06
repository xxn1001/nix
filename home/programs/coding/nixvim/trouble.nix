{
  programs.nixvim = {
    plugins.trouble.enable = true;
    keymaps = [
      {
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options = { silent = true; desc = "切换诊断面板 (Trouble)"; };
      }
      {
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        options = { silent = true; desc = "切换当前缓冲区诊断面板 (Trouble)"; };
      }
      {
        key = "<leader>cl";
        action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
        options = { silent = true; desc = "切换 LSP 引用面板 (Trouble)"; };
      }
      {
        key = "<leader>xL";
        action = "<cmd>Trouble loclist toggle<cr>";
        options = { silent = true; desc = "切换位置列表面板 (Trouble)"; };
      }
      {
        key = "<leader>xQ";
        action = "<cmd>Trouble qflist toggle<cr>";
        options = { silent = true; desc = "切换 quickfix 列表面板 (Trouble)"; };
      }
      {
        key = "[q";
        action.__raw = ''
          function()
            if require("trouble").is_open() then
              require("trouble").previous({ skip_groups = true, jump = true })
            else
              vim.cmd.cprev()
            end
          end
        '';
        options = { silent = true; desc = "上一个故障/快速修复项目"; };
      }
      {
        key = "]q";
        action.__raw = ''
          function()
            if require("trouble").is_open() then
              require("trouble").next({ skip_groups = true, jump = true })
            else
              vim.cmd.cnext()
            end
          end
        '';
        options = { silent = true; desc = "下一个故障/快速修复项目"; };
      }
    ];
  };
}
