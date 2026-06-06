{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./autocmd.nix
    ./keymap.nix
    ./colorscheme.nix
    ./lsp.nix
    ./conform.nix
    ./blink.nix
    ./lualine.nix
    ./treesitter.nix
    ./ufo.nix
    ./flash.nix
    ./ui.nix
    ./mini.nix
    ./dap.nix
    ./noice.nix
    ./neo-tree.nix
    ./dashboard.nix
    ./todo-comments.nix
    ./harpoon.nix
    ./toggleterm.nix
    ./persistence.nix
    ./autotag.nix
    ./aerial.nix
    ./trouble.nix
    ./project.nix
  ];
  stylix.targets.nixvim.enable = true;
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    performance.combinePlugins.enable = false;
    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };
    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
      showmode = false;
      clipboard.providers.wl-copy.enable = true;
      breakindent = true;
      tabstop = 2;
      shiftwidth = 2;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      updatetime = 250;
      timeoutlen = 300;
      splitright = true;
      splitbelow = true;
      list = true;
      listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";
      inccommand = "split";
      cursorline = true;
      hlsearch = false;
      scrolloff = 8;
      spell = true;
      spelllang = [ "en_us" "cjk" ];
      spellsuggest = "best,4";
      wrap = false;
      signcolumn = "yes";
      termguicolors = true;
      foldmethod = "expr";
      foldexpr = "v:lua.vim.ufo.foldexpr()";
      foldenable = true;
      foldlevelstart = 99;
      sessionoptions = [ "buffers" "curdir" "tabpages" "winsize" "help" "globals" "skiprtp" "folds" ];
    };
    keymaps = [
      { mode = "n"; key = "<Leader>ch"; action = "<cmd>lua ToggleHeader()<CR>"; }
      { mode = "n"; key = "<Leader>cb"; action = "<cmd>!g++ -std=c++20 -Wall -O2 -o %:r %<CR>"; }
      { mode = "n"; key = "<Leader>cr"; action = "<cmd>!g++ -std=c++20 -Wall -O2 -o %:r % && ./%:r<CR>"; }
      { mode = "n"; key = "<Leader>gb"; action = "<cmd>!go build ./...<CR>"; }
      { mode = "n"; key = "<Leader>gt"; action = "<cmd>!go test -v ./...<CR>"; }
      { mode = "n"; key = "<Leader>gr"; action = "<cmd>!go run .<CR>"; }
    ];
    plugins = {
      sleuth.enable = true;
      nvim-surround.enable = true;
      repeat.enable = true;
      lastplace.enable = true;
      nvim-autopairs.enable = true;
      endwise.enable = true;
      markdown-preview.enable = true;
      web-devicons.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [ fcitx-vim ];
    extraConfigLua = ''
      local M = {}
      function M.toggle_header()
        local ext = vim.fn.expand("%:e")
        local base = vim.fn.expand("%:r")
        local headers = { h = true, hpp = true, hxx = true, hh = true }
        local sources = { c = true, cpp = true, cxx = true, cc = true }
        if headers[ext] then
          for _, s in ipairs({ "cpp", "cxx", "cc", "c" }) do
            local f = base .. "." .. s
            if vim.fn.filereadable(f) == 1 then
              vim.cmd("e " .. f)
              return
            end
          end
          vim.cmd("e " .. base .. ".cpp")
        elseif sources[ext] then
          for _, h in ipairs({ "hpp", "hxx", "hh", "h" }) do
            local f = base .. "." .. h
            if vim.fn.filereadable(f) == 1 then
              vim.cmd("e " .. f)
              return
            end
          end
          vim.cmd("e " .. base .. ".h")
        end
      end
      _G.ToggleHeader = M.toggle_header
    '';
  };
}
