{
  programs.nixvim.plugins.harpoon2 = {
    enable = true;
    settings = {
      save_on_toggle = true;
      save_on_change = true;
    };
  };
  programs.nixvim.keymaps = [
    {
      key = "<leader>ma";
      action.__raw = "function() require('harpoon'):list():add() end";
      options = { silent = true; desc = "添加标记"; };
    }
    {
      key = "<leader>md";
      action.__raw = "function() require('harpoon'):list():remove() end";
      options = { silent = true; desc = "移除标记"; };
    }
    {
      key = "<leader>mm";
      action.__raw = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
      options = { silent = true; desc = "切换Harpoon菜单"; };
    }
    {
      key = "<leader>m1";
      action.__raw = "function() require('harpoon'):list():select(1) end";
      options = { silent = true; desc = "跳转标记1"; };
    }
    {
      key = "<leader>m2";
      action.__raw = "function() require('harpoon'):list():select(2) end";
      options = { silent = true; desc = "跳转标记2"; };
    }
    {
      key = "<leader>m3";
      action.__raw = "function() require('harpoon'):list():select(3) end";
      options = { silent = true; desc = "跳转标记3"; };
    }
    {
      key = "<leader>m[";
      action.__raw = "function() require('harpoon'):list():prev() end";
      options = { silent = true; desc = "上一个标记"; };
    }
    {
      key = "<leader>m]";
      action.__raw = "function() require('harpoon'):list():next() end";
      options = { silent = true; desc = "下一个标记"; };
    }
  ];
}
