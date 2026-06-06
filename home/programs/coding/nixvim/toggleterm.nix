{
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      settings = {
        size.__raw = ''
          function(term)
            if term.direction == "horizontal" then
              return 8
            elseif term.direction == "vertical" then
              return vim.o.columns * 0.4
            end
          end
        '';
        open_mapping = "[[<C-\\>]]";
        persist_size = true;
        direction = "float";
        float_opts = {
          border = "single";
          winblend = 0;
          height = 20;
          width = 80;
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>tt";
        action = "<cmd>ToggleTerm<cr>";
        options = { silent = true; desc = "启用终端"; };
      }
      {
        mode = "n";
        key = "<leader>tv";
        action = "<cmd>ToggleTerm direction=vertical<cr>";
        options = { silent = true; desc = "切换垂直终端窗口"; };
      }
      {
        mode = "n";
        key = "<leader>th";
        action = "<cmd>ToggleTerm direction=horizontal<cr>";
        options = { silent = true; desc = "切换水平终端窗口"; };
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>ToggleTerm direction=float<cr>";
        options = { silent = true; desc = "切换浮动终端窗口"; };
      }
      {
        mode = "t";
        key = "<esc>";
        action = "<C-\\><C-n>";
        options = { silent = true; desc = "终端退到Normal模式"; };
      }
    ];
  };
}
