{
  programs.nixvim.keymaps = [
    # --- 智能行移动 ---
    {
      mode = "n";
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = { expr = true; silent = true; };
    }
    {
      mode = "n";
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = { expr = true; silent = true; };
    }

    # --- 保存/退出 ---
    {
      mode = [ "i" "n" "v" "s" ];
      key = "<C-s>";
      action = "<Cmd>w<CR>";
      options = { silent = true; desc = "保存文件"; };
    }
    {
      mode = "n";
      key = "<leader>qq";
      action = "<cmd>wqa<cr>";
      options = { desc = "退出编辑器"; };
    }
    {
      mode = "n";
      key = "Q";
      action = "<cmd>bd<cr>";
      options = { silent = true; desc = "关闭缓冲区"; };
    }

    # --- 全选 ---
    {
      mode = [ "i" "n" ];
      key = "<C-a>";
      action = "<Cmd>normal! ggVG<CR>";
      options = { silent = true; desc = "全选操作"; };
    }

    # --- 窗口大小调整 ---
    {
      mode = "n";
      key = "<C-Up>";
      action = "<cmd>resize +2<cr>";
      options = { desc = "增加窗口高度"; };
    }
    {
      mode = "n";
      key = "<C-Down>";
      action = "<cmd>resize -2<cr>";
      options = { desc = "减少窗口高度"; };
    }
    {
      mode = "n";
      key = "<C-Left>";
      action = "<cmd>vertical resize -2<cr>";
      options = { desc = "减少窗口宽度"; };
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = "<cmd>vertical resize +2<cr>";
      options = { desc = "增加窗口宽度"; };
    }

    # --- 窗口移动 ---
    {
      mode = "n";
      key = "<leader>wH";
      action = "<C-w>H";
      options = { silent = true; desc = "窗口移到左边"; };
    }
    {
      mode = "n";
      key = "<leader>wJ";
      action = "<C-w>J";
      options = { silent = true; desc = "窗口移到底部"; };
    }
    {
      mode = "n";
      key = "<leader>wK";
      action = "<C-w>K";
      options = { silent = true; desc = "窗口移到顶部"; };
    }
    {
      mode = "n";
      key = "<leader>wL";
      action = "<C-w>L";
      options = { silent = true; desc = "窗口移到右边"; };
    }

    # --- 行移动 ---
    {
      mode = "n";
      key = "<A-j>";
      action = ":m .+1<CR>==";
      options = { silent = true; desc = "向下移动行"; };
    }
    {
      mode = "n";
      key = "<A-k>";
      action = ":m .-2<CR>==";
      options = { silent = true; desc = "向上移动行"; };
    }
    {
      mode = "v";
      key = "<A-j>";
      action = ":m '>+1<CR>gv=gv";
      options = { silent = true; desc = "向下移动选择"; };
    }
    {
      mode = "v";
      key = "<A-k>";
      action = ":m '<-2<CR>gv=gv";
      options = { silent = true; desc = "向上移动选择"; };
    }

    # --- Tab 管理 ---
    {
      mode = "n";
      key = "<leader><tab><tab>";
      action = "<cmd>tabnew<CR>";
      options = { silent = true; desc = "新建标签页"; };
    }
    {
      mode = "n";
      key = "<leader><tab>d";
      action = "<cmd>tabclose<CR>";
      options = { silent = true; desc = "关闭当前标签页"; };
    }
    {
      mode = "n";
      key = "<leader><tab>o";
      action = "<cmd>tabonly<CR>";
      options = { silent = true; desc = "关闭其他标签页"; };
    }
    {
      mode = "n";
      key = "<leader><tab>l";
      action = "<cmd>tabnext<CR>";
      options = { silent = true; desc = "切换到下一个标签页"; };
    }
    {
      mode = "n";
      key = "<leader><tab>h";
      action = "<cmd>tabprevious<CR>";
      options = { silent = true; desc = "切换到上一个标签页"; };
    }

    # --- 终端退出 ---
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-n>";
      options = { silent = true; desc = "终端退到Normal模式"; };
    }

    # --- 帮助查询 ---
    {
      mode = "n";
      key = "<leader>H";
      action = "<CMD>Telescope help_tags theme=ivy layout_config={height=0.4}<CR>";
      options = { silent = true; desc = "帮助查询"; };
    }

    # --- 切换 ---
    {
      mode = "n";
      key = "<leader>ss";
      action = "<cmd>set spell!<cr>";
      options = { silent = true; desc = "切换拼写检查"; };
    }
    {
      mode = "n";
      key = "<leader>sd";
      action = "<cmd>lua ToggleDiagnostics()<CR>";
      options = { silent = true; desc = "切换语法诊断"; };
    }
  ];
}
