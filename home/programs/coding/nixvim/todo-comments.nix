{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
    settings.signs = true;
  };
  programs.nixvim.keymaps = [
    {
      key = "<leader>ft";
      action = "<cmd>Telescope todo-comments todo theme=dropdown<cr>";
      options = { silent = true; desc = "TODO查询"; };
    }
  ];
}
