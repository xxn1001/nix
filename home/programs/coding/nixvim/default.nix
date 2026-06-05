{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./lsp.nix
    ./cmp.nix
    ./lualine.nix
    ./treesitter.nix
    ./hop.nix
    ./ui.nix
    ./mini.nix
    ./dap.nix
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
      hlsearch = true;
      scrolloff = 10;
      spell = true;
      spelllang = [ "en_us" "cjk" ];
      spellsuggest = "best,4";
    };
    keymaps = [
      { mode = "n"; key = "S"; action = ":w<cr>"; }
      { mode = "n"; key = "Q"; action = ":bd<cr>"; }
      { mode = "t"; key = "<Esc><Esc>"; action = "<C-\\><C-n>"; }
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
