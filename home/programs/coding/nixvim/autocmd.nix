{
  programs.nixvim = {
    autoGroups = {
      highlight-yank.clear = true;
    };
    autoCmd = [
      {
        desc = "取消自动换行注释";
        event = "FileType";
        pattern = "*";
        callback.__raw = ''
          function()
            vim.opt_local.formatoptions:remove({ "c", "r" })
          end
        '';
      }
      {
        desc = "部分文档文件开启自动软换行并添加中文符号作为换行标志";
        event = "FileType";
        pattern = [ "markdown" "text" ];
        callback.__raw = ''
          function()
            vim.opt_local.wrap = true
            vim.opt_local.linebreak = true
            vim.opt_local.breakat:append("，。！？；：")
            vim.opt_local.expandtab = true
            vim.opt_local.shiftwidth = 2
            vim.opt_local.tabstop = 2
            vim.opt_local.softtabstop = 2
          end
        '';
      }
      {
        desc = "复制高亮";
        event = "TextYankPost";
        pattern = "*";
        group = "highlight-yank";
        callback.__raw = ''
          function()
            vim.highlight.on_yank({ timeout = 500 })
          end
        '';
      }
      {
        desc = "noice背景颜色设置";
        event = "ColorScheme";
        pattern = "*";
        callback.__raw = ''
          function()
            local bg = vim.api.nvim_get_hl_by_name("Normal", true).background
            if bg then
              bg = string.format("#%06x", bg)
            else
              bg = "#000000"
            end
            vim.cmd("highlight NotifyBackground guibg=" .. bg)
          end
        '';
      }
      {
        desc = "禁用首页的缩进线和指南线";
        event = "FileType";
        pattern = [ "dashboard" "alpha" "snacks_dashboard" ];
        once = true;
        callback.__raw = ''
          function()
            vim.b.miniindentscope_disable = true
            vim.opt_local.list = false
            pcall(function() require("ibl").setup_buffer(0, { enabled = false }) end)
            vim.g.indent_blankline_enabled = false
          end
        '';
      }
      {
        desc = "自定义事件CookLazy";
        event = "VimEnter";
        once = true;
        callback.__raw = ''
          function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("User", { pattern = "CookLazy" })
            end)
          end
        '';
      }
      {
        desc = "自定义事件LazyFile";
        event = [ "BufReadPost" "BufNewFile" ];
        once = true;
        callback.__raw = ''
          function()
            if not vim.g._lazyfile_triggered then
              vim.g._lazyfile_triggered = true
              vim.schedule(function()
                vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile" })
              end)
            end
          end
        '';
      }
    ];
  };
}
