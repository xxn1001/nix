{
  programs.nixvim.plugins = {
    telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        file-browser.enable = true;
        live-grep-args.enable = true;
      };
      settings.defaults.mappings = {
        i = {
          "<A-s>" = { __raw = "require('telescope.actions').file_split"; };
          "<A-v>" = { __raw = "require('telescope.actions').file_vsplit"; };
          "<A-t>" = { __raw = "require('telescope.actions').file_tab"; };
        };
        n = {
          "<A-s>" = { __raw = "require('telescope.actions').file_split"; };
          "<A-v>" = { __raw = "require('telescope.actions').file_vsplit"; };
          "<A-t>" = { __raw = "require('telescope.actions').file_tab"; };
        };
      };
    };
    bufferline.enable = true;
    gitsigns = {
      enable = true;
      settings = {
        signs = {
          add.text = "│";
          change.text = "│";
          changedelete.text = "~";
          delete.text = "_";
          topdelete.text = "‾";
          untracked.text = "┆";
        };
        current_line_blame = true;
        current_line_blame_opts = {
          virt_text = true;
          virt_text_pos = "eol";
          delay = 500;
          ignore_whitespace = false;
          virt_text_priority = 100;
          use_focus = true;
        };
        preview_config = {
          style = "minimal";
          relative = "cursor";
          row = 0;
          col = 1;
        };
        on_attach = ''
          function(bufnr)
            local gitsigns = require("gitsigns")
            local function map(mode, l, r, desc, opts)
              opts = opts or {}
              opts.buffer = bufnr
              if desc then opts.desc = desc end
              vim.keymap.set(mode, l, r, opts)
            end
            map("n", "]c", function()
              if vim.wo.diff then vim.cmd.normal({ "]c", bang = true })
              else gitsigns.nav_hunk("next") end
            end, "跳转到下一个修改块")
            map("n", "[c", function()
              if vim.wo.diff then vim.cmd.normal({ "[c", bang = true })
              else gitsigns.nav_hunk("prev") end
            end, "跳转到上一个修改块")
            map("n", "<leader>hp", gitsigns.preview_hunk, "预览Hunk(弹窗)")
            map("n", "<leader>hi", gitsigns.preview_hunk_inline, "行内预览Hunk")
            map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, "显示blame弹窗信息")
            map("n", "<leader>hd", gitsigns.diffthis, "显示文件差异(索引)")
            map("n", "<leader>hD", function() gitsigns.diffthis("~") end, "显示文件差异(HEAD)")
            map("n", "<leader>hQ", function() gitsigns.setqflist("all") end, "所有Git变更到Quickfix")
            map("n", "<leader>hq", gitsigns.setqflist, "当前文件变更到Quickfix")
            map("n", "<leader>ht", gitsigns.toggle_current_line_blame, "切换行内blame显示")
            map("n", "<leader>hw", gitsigns.toggle_word_diff, "切换行内单词差异")
            map({ "o", "x" }, "ih", gitsigns.select_hunk, "选择Git hunk")
          end
        '';
      };
    };
    indent-blankline.enable = true;
    colorizer = {
      enable = true;
      settings.user_default_options = {
        mode = "virtualtext";
        css = true;
        css_fn = true;
        names = false;
        virtualtext = "■";
        virtualtext_inline = true;
        virtualtext_mode = "foreground";
      };
    };
    which-key = {
      enable = true;
      settings.spec = [
        { __unkeyed = "<Leader>f"; name = "Telescope"; }
        { __unkeyed = "<Leader>c"; name = "C/C++ / LSP"; }
        { __unkeyed = "<Leader>g"; name = "Go"; }
        { __unkeyed = "<Leader>d"; name = "Debug"; }
        { __unkeyed = "<Leader>h"; name = "Git Hunk"; }
        { __unkeyed = "<Leader>m"; name = "Harpoon"; }
        { __unkeyed = "<Leader>t"; name = "Terminal"; }
        { __unkeyed = "<Leader>w"; name = "Window"; }
        { __unkeyed = "<Leader>x"; name = "Trouble/Diagnostics"; }
        { __unkeyed = "<Leader><tab>"; name = "Tab"; }
      ];
    };
    render-markdown = {
      enable = true;
    };
  };
  programs.nixvim.keymaps = [
    {
      key = "<leader>fp";
      action = "<CMD>Telescope projects layout_config={height=0.6,width=0.6}<CR>";
      options = { silent = true; desc = "切换项目"; };
    }
    {
      key = "<leader>ff";
      action = "<CMD>Telescope find_files theme=dropdown previewer=false layout_config={height=0.3}<CR>";
      options = { silent = true; desc = "查找文件"; };
    }
    {
      key = "<leader>fs";
      action = "<CMD>Telescope grep_string theme=ivy layout_config={height=0.4}<CR>";
      options = { silent = true; desc = "字符快搜"; };
    }
    {
      key = "<leader>fg";
      action = "<CMD>Telescope live_grep theme=ivy layout_config={height=0.4}<CR>";
      options = { silent = true; desc = "全局搜索"; };
    }
    {
      key = "<leader>fb";
      action = "<CMD>Telescope buffers layout_config={mirror=true,prompt_position=top,height=0.4,width=0.6} layout_strategy=vertical previewer=false<CR>";
      options = { silent = true; desc = "查看缓冲区"; };
    }
    {
      key = "<leader>fo";
      action = "<CMD>Telescope oldfiles theme=dropdown previewer=false layout_config={height=0.3}<CR>";
      options = { silent = true; desc = "历史文件"; };
    }
    {
      key = "<leader>fr";
      action = "<CMD>Telescope live_grep_args theme=ivy layout_config={height=0.4}<CR>";
      options = { silent = true; desc = "高级搜索"; };
    }
    {
      key = "<leader>fk";
      action = "<CMD>Telescope keymaps layout_config={width=0.8}<CR>";
      options = { silent = true; desc = "快捷键查询"; };
    }
  ];
  programs.nixvim.extraConfigLua = ''
    require("render-markdown").setup({
      file_types = { "markdown", "codecompanion" },
      latex = { enabled = true, converter = "latex2text" },
      win_options = { conceallevel = { rendered = 2 } },
    })
  '';
}
