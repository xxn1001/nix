{
  programs.nixvim = {
    plugins.cmp = {
      enable = true;
      settings = {
        sources = [
          { name = "buffer"; }
          { name = "path"; }
          { name = "spell"; }
          { name = "luasnip"; }
          { name = "nvim_lsp"; }
        ];
        mapping = {
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
        window.completion.border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
      };
    };
    plugins.cmp-buffer.enable = true;
    plugins.cmp-path.enable = true;
    plugins.luasnip.enable = true;
    plugins.cmp_luasnip.enable = true;
    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp-spell.enable = true;
  };
}
