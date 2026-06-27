{
  pkgs,
  ...
}:
let
  plugins = with pkgs.vimPlugins; [
    nvim-surround
    nvim-autopairs
    vim-sleuth
    vim-repeat
    vim-endwise
    vim-lastplace
    mini-nvim
  ];

  pluginName = p:
    let m = builtins.match "vimplugin-(.*)" (p.pname or p.name);
    in if m == null then p.pname or p.name else builtins.head m;
in
{
  xdg.dataFile = builtins.listToAttrs (
    builtins.map (p: {
      name = "nvim-vscode/site/pack/vscode/start/${pluginName p}";
      value = { source = "${p}"; };
    }) plugins
  );

  xdg.configFile."nvim-vscode/init.lua".text = ''
    if not vim.g.vscode then
      vim.notify("此配置仅用于 VSCode Neovim", vim.log.levels.WARN)
      return
    end

    local has_vscode, vscode = pcall(require, "vscode-neovim")
    if not has_vscode then
      vim.notify("vscode-neovim 模块未找到", vim.log.levels.ERROR)
      return
    end

    -- ====================================================================
    -- 基础选项（对齐 nixvim 配置）
    -- ====================================================================
    local opt = vim.opt
    opt.number = true
    opt.relativenumber = true
    opt.mouse = "a"
    opt.showmode = false
    opt.breakindent = true
    opt.tabstop = 2
    opt.shiftwidth = 2
    opt.undofile = true
    opt.ignorecase = true
    opt.smartcase = true
    opt.updatetime = 250
    opt.timeoutlen = 300
    opt.splitright = true
    opt.splitbelow = true
    opt.list = true
    opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
    opt.inccommand = "split"
    opt.cursorline = true
    opt.hlsearch = false
    opt.scrolloff = 8
    opt.spell = true
    opt.spelllang = "en_us,cjk"
    opt.wrap = false
    opt.signcolumn = "yes"
    opt.termguicolors = true
    opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
    vim.g.have_nerd_font = true

    -- ====================================================================
    -- 插件配置（插件已通过 packpath 自动加载，无需设 rtp）
    -- ====================================================================

    pcall(function() require("nvim-surround").setup({}) end)
    pcall(function() require("nvim-autopairs").setup({}) end)

    pcall(function()
      require("mini.move").setup({
        mappings = {
          left = "<C-h>",  right = "<C-l>",
          up   = "<C-k>",  down  = "<C-j>",
          line_left  = "<C-h>", line_right = "<C-l>",
          line_up    = "<C-k>", line_down  = "<C-j>",
        },
      })
    end)

    pcall(function() require("mini.comment").setup({}) end)

    vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"

    -- ====================================================================
    -- 快捷键映射
    --
    -- [N] = Neovim 原生命令（两侧体验一致）
    -- [V] = 桥接 VSCode 功能（同键位不同后端）
    -- ====================================================================

    local map = vim.keymap.set

    local function vsc_map(mode, lhs, cmd, desc)
      map(mode, lhs, function() vscode.action(cmd) end, { silent = true, desc = desc })
    end

    local function nv_map(mode, lhs, rhs, desc)
      map(mode, lhs, rhs, { silent = true, desc = desc })
    end

    ---------------------------------------------------------------------------
    -- 编辑操作 [N]
    ---------------------------------------------------------------------------

    nv_map({ "i", "n", "v", "s" }, "<C-s>", "<cmd>w<cr>", "保存文件")
    nv_map("n", "Q", "<cmd>bd<cr>", "关闭缓冲区")
    nv_map("n", "<leader>bn", "<cmd>bnext<cr>", "下一个缓冲区")
    nv_map("n", "<leader>bp", "<cmd>bprevious<cr>", "上一个缓冲区")

    -- 行移动（Alt 键在 VSCode 中可能被拦截，如果没有生效请改用 <leader>j/k）
    nv_map("n", "<A-j>", ":m .+1<CR>==", "向下移动行")
    nv_map("n", "<A-k>", ":m .-2<CR>==", "向上移动行")
    nv_map("v", "<A-j>", ":m '>+1<CR>gv=gv", "向下移动选择")
    nv_map("v", "<A-k>", ":m '<-2<CR>gv=gv", "向上移动选择")

    nv_map("n", "<leader>ss", "<cmd>set spell!<cr>", "切换拼写检查")

    ---------------------------------------------------------------------------
    -- LSP 操作 [V]
    ---------------------------------------------------------------------------

    vsc_map("n", "gd", "editor.action.revealDefinition", "跳转到定义")
    vsc_map("n", "gr", "references-view.findReferences", "查找引用")
    vsc_map("n", "gD", "editor.action.revealDeclaration", "跳转到声明")
    vsc_map("n", "gI", "editor.action.goToImplementation", "查找实现")
    vsc_map("n", "gt", "editor.action.goToTypeDefinition", "跳转到类型定义")
    vsc_map("n", "K", "editor.action.showHover", "悬浮文档")
    vsc_map("n", "<leader>cR", "editor.action.rename", "重命名符号")
    vsc_map("n", "<leader>ca", "editor.action.quickFix", "代码操作")
    vsc_map("n", "<leader>cf", "workbench.action.gotoSymbol", "文件大纲")
    vsc_map("n", "<leader>cw", "workbench.action.showAllSymbols", "工作区符号")
    vsc_map("n", "<leader>ci", "editor.action.goToImplementation", "查找实现")
    vsc_map("n", "<leader>cG", "references-view.findReferences", "查找引用")

    -- 诊断导航 [V]
    vsc_map("n", "[d", "editor.action.marker.prev", "上一个诊断")
    vsc_map("n", "]d", "editor.action.marker.next", "下一个诊断")
    vsc_map("n", "<leader>ce", "workbench.action.showErrorsWarnings", "当前文件诊断")
    vsc_map("n", "<leader>cW", "workbench.panel.markers.view.focus", "全局诊断")
    vsc_map("n", "<leader>cd", "editor.action.peekProblem", "当前行诊断浮窗")

    ---------------------------------------------------------------------------
    -- 文件 / 搜索 / UI [V]
    ---------------------------------------------------------------------------

    vsc_map("n", "<leader>ff", "workbench.action.quickOpen", "查找文件")
    vsc_map("n", "<leader>fg", "workbench.action.findInFiles", "全局搜索")
    vsc_map("n", "<leader>fs", "workbench.action.findInFiles", "字符快搜")
    vsc_map("n", "<leader>fb", "workbench.action.showAllEditors", "查看缓冲区")
    vsc_map("n", "<leader>fo", "workbench.action.openRecent", "历史文件")
    vsc_map("n", "<leader>fp", "workbench.action.openRecent", "切换项目")
    vsc_map("n", "<leader>fk", "workbench.action.openGlobalKeybindings", "快捷键查询")
    vsc_map("n", "<leader>e", "workbench.view.explorer", "文件树")

    -- 终端 [V]
    vsc_map("n", "<leader>tt", "workbench.action.terminal.toggle", "打开/关闭终端")
    vsc_map("n", "<leader>tv", "workbench.action.terminal.split", "垂直分屏终端")
    vsc_map("n", "<leader>th", "workbench.action.terminal.split", "水平分屏终端")

    -- 诊断面板 [V]
    vsc_map("n", "<leader>xx", "workbench.actions.view.problems", "切换诊断面板")
    vsc_map("n", "<leader>xX", "workbench.panel.markers.view.focus", "当前缓冲区诊断")

    -- 命令面板 [V]
    nv_map("n", "<leader>:", "<cmd>lua require('vscode-neovim').action('workbench.action.showCommands')<cr>", "命令面板")

    ---------------------------------------------------------------------------
    -- Git [V]
    ---------------------------------------------------------------------------

    vsc_map("n", "]c", "editor.action.dirtydiff.next", "下一个修改")
    vsc_map("n", "[c", "editor.action.dirtydiff.previous", "上一个修改")
    vsc_map("n", "<leader>hp", "git.openChange", "预览Hunk")
    vsc_map("n", "<leader>hb", "git.toggleBlame", "显示Blame")
    vsc_map("n", "<leader>hd", "git.openChange", "显示文件差异")
    vsc_map("n", "<leader>ht", "git.toggleBlame", "切换行内Blame")

    ---------------------------------------------------------------------------
    -- Tab 管理 [V]
    ---------------------------------------------------------------------------

    vsc_map("n", "<leader><tab><tab>", "workbench.action.newGroupBelow", "新建标签页")
    vsc_map("n", "<leader><tab>d", "workbench.action.closeActiveEditor", "关闭标签页")
    vsc_map("n", "<leader><tab>l", "workbench.action.nextEditor", "下一个标签页")
    vsc_map("n", "<leader><tab>h", "workbench.action.previousEditor", "上一个标签页")

    -- ====================================================================
    -- 自动命令
    -- ====================================================================

    local group = vim.api.nvim_create_augroup("VSCodeNvim", { clear = true })

    vim.api.nvim_create_autocmd("TextYankPost", {
      group = group,
      callback = function() vim.highlight.on_yank({ timeout = 500 }) end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "*",
      callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r" })
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = { "markdown", "text" },
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
      end,
    })
  '';
}
