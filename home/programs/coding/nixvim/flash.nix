{
  programs.nixvim.plugins.flash.enable = true;
  programs.nixvim.keymaps = [
    {
      mode = [ "n" "x" "o" ];
      key = "s";
      action.__raw = ''
        function()
          require("flash").jump()
        end
      '';
      options = { silent = true; desc = "flash跳转"; };
    }
    {
      mode = [ "n" "x" "o" ];
      key = "S";
      action.__raw = ''
        function()
          require("flash").treesitter()
        end
      '';
      options = { silent = true; desc = "flash Treesitter跳转"; };
    }
    {
      mode = "o";
      key = "r";
      action.__raw = ''
        function()
          require("flash").remote()
        end
      '';
      options = { silent = true; desc = "远程跳转"; };
    }
    {
      mode = [ "o" "x" ];
      key = "R";
      action.__raw = ''
        function()
          require("flash").treesitter_search()
        end
      '';
      options = { silent = true; desc = "treesitter搜索"; };
    }
  ];
}
