# NixVim 配置指南

本配置基于 CookNixvim 理念重构，通过 home-manager 模块化组织。  
所有插件与设置均可声明式管理，构建后生效。

---

## 目录结构

```
home/programs/coding/nixvim/
├── default.nix          # 入口：imports 所有子模块、全局 opts、stylix 集成
├── autocmd.nix          # 自动命令（yank 高亮、markdown 换行等）
├── keymap.nix           # 通用快捷键（窗口、tab、行移动、保存/退出）
├── colorscheme.nix      # stylix 自动配色 + 透明弹窗
│
├── lsp.nix              # LSP 语言服务器（clangd、gopls、rust_analyzer 等 20+）
├── conform.nix          # 代码格式化（prettier、clang-format、gofumpt 等）
├── blink.nix            # 补全引擎 nvim-cmp（buffer/path/spell/luasnip/LSP）
│
├── lualine.nix          # 状态栏（stylix 配色）
├── treesitter.nix       # 语法高亮 + rainbow-delimiters
├── ufo.nix              # 代码折叠（treesitter + indent）
├── ui.nix               # Telescope、bufferline、which-key、gitsigns、colorizer
├── mini.nix             # mini.align/files/hipatterns/indentscope/move
├── flash.nix            # 快速跳转（替代 hop.nvim）
├── noice.nix            # 命令行/消息 UI 增强
│
├── neo-tree.nix         # 文件树
├── dashboard.nix        # 启动页（alpha.nvim）
├── aerial.nix           # 代码大纲
├── trouble.nix          # 诊断/引用面板
├── todo-comments.nix    # TODO/FIXME 高亮
│
├── dap.nix              # 调试器（codelldb、delve、pwa-node）
├── harpoon.nix          # 文件快捷跳转
├── toggleterm.nix       # 内嵌终端
├── persistence.nix      # 会话恢复
├── autotag.nix          # HTML/XML 标签自动补全
└── project.nix          # 项目管理
```

---

## 快捷键速查

> `<leader>` = 空格键

### 通用操作

| 快捷键 | 功能 |
|--------|------|
| `<C-s>` | 保存文件 |
| `<leader>qq` | 保存全部并退出 |
| `Q` | 关闭当前缓冲 |
| `<leader>H` | 打开帮助文档 |

### 窗口管理

| 快捷键 | 功能 |
|--------|------|
| `<C-Up>` / `<C-Down>` | 增减窗口高度 |
| `<C-Left>` / `<C-Right>` | 增减窗口宽度 |
| `<leader>wH/J/K/L` | 移动当前窗口到左/下/上/右 |

### Tab 管理

| 快捷键 | 功能 |
|--------|------|
| `<leader><tab><tab>` | 新建标签页 |
| `<leader><tab>d` | 关闭标签页 |
| `<leader><tab>o` | 关闭其他标签页 |
| `<leader><tab>l/h` | 下/上一个标签页 |

### 文件查找 `<leader>f`

| 快捷键 | 功能 |
|--------|------|
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全局内容搜索 |
| `<leader>fs` | 光标下单词搜索 |
| `<leader>fr` | 高级搜索（支持参数）|
| `<leader>fb` | 查看缓冲区列表 |
| `<leader>fo` | 历史文件 |
| `<leader>fp` | 切换项目 |
| `<leader>ft` | TODO 查询 |
| `<leader>fk` | 快捷键查询 |

Telescope 内快捷键：

| 快捷键 | 功能 |
|--------|------|
| `<A-s>` | 水平分屏打开 |
| `<A-v>` | 垂直分屏打开 |
| `<A-t>` | 新标签页打开 |

### C/C++ 开发 `<leader>c`（也包含 LSP 功能）

| 快捷键 | 功能 |
|--------|------|
| `<leader>ch` | C/C++ header ↔ source 切换 |
| `<leader>cb` | g++ 编译当前文件 |
| `<leader>cr` | g++ 编译并运行 |
| `gD` | 跳转到声明 |
| `gd` | 跳转到定义 |
| `gr` | 查找引用 |
| `gI` | 查找实现 |
| `gt` | 跳转到类型定义 |
| `<leader>ci` | 查找实现 (Telescope) |
| `<leader>cG` | 查找引用 (Telescope) |
| `<leader>cw` | 工作区符号搜索 |
| `<leader>cf` | 文件大纲 |
| `<leader>c[` / `c]` | 被调/调用列表 |
| `<leader>ce` | 当前文件诊断 |
| `<leader>cW` | 全局诊断 |
| `<leader>cd` | 打开当前行诊断浮窗 |
| `<leader>cR` | 重命名符号 |
| `<leader>ca` | 代码操作（Quick Fix） |
| `<leader>cs` | 切换符号面板 (Aerial) |
| `<leader>cl` | 切换 LSP 引用面板 (Trouble) |
| `K` | 查看折叠内容 / LSP 悬浮文档 |
| `[` / `]` | 上一个/下一个诊断 |

### Go 开发

| 快捷键 | 功能 |
|--------|------|
| `<leader>gb` | go build ./... |
| `<leader>gt` | go test -v ./... |
| `<leader>gr` | go run . |

### 调试 `<leader>d`

| 快捷键 | 功能 |
|--------|------|
| `<F5>` | 继续执行 |
| `<F9>` | 切换断点 |
| `<F10>` | 单步跳过 |
| `<F11>` | 单步进入 |
| `<F12>` | 单步退出 |
| `<leader>du` | 切换调试 UI |
| `<leader>dt` | 切换 REPL |

支持语言：C/C++/Rust (codelldb)、Go (delve)、JavaScript/TypeScript (pwa-node)。

### Git

| 快捷键 | 功能 |
|--------|------|
| `]c` / `[c` | 下一个/上一个 Hunk |
| `<leader>hp` | 预览 Hunk 弹窗 |
| `<leader>hi` | 行内预览 Hunk |
| `<leader>hb` | 显示 Blame 弹窗 |
| `<leader>hd` | 显示差异（索引）|
| `<leader>hD` | 显示差异（HEAD）|
| `<leader>hQ` | 所有变更到 Quickfix |
| `<leader>hq` | 当前文件变更到 Quickfix |
| `<leader>ht` | 切换行内 Blame |
| `<leader>hw` | 切换单词差异 |
| `ih` | 选择 Git Hunk（operator-pending） |

### 文件树 Neo-tree

| 快捷键 | 功能 |
|--------|------|
| `<leader>e` | 打开/关闭文件树 |

### Harpoon 文件标记 `<leader>m`

| 快捷键 | 功能 |
|--------|------|
| `<leader>ma` | 添加标记 |
| `<leader>md` | 移除标记 |
| `<leader>mm` | 打开标记菜单 |
| `<leader>m1/m2/m3` | 跳转到标记 1/2/3 |
| `<leader>m[` / `m]` | 上一个/下一个标记 |

### 终端 `<leader>t`

| 快捷键 | 功能 |
|--------|------|
| `<leader>tt` | 打开浮动终端 |
| `<leader>tv` | 垂直分屏终端 |
| `<leader>th` | 水平分屏终端 |
| `<leader>tf` | 浮动终端 |
| `<esc>` | 终端 → Normal 模式 |

### 诊断面板 (Trouble) `<leader>x`

| 快捷键 | 功能 |
|--------|------|
| `<leader>xx` | 切换诊断面板 |
| `<leader>xX` | 当前缓冲区诊断 |
| `<leader>xL` | 位置列表 |
| `<leader>xQ` | Quickfix 列表 |
| `[q` / `]q` | 上一个/下一个项目 |

### 快速跳转 (Flash)

| 快捷键 | 功能 |
|--------|------|
| `s` | 任意位置跳转 |
| `S` | Treesitter 节点跳转 |

### 代码折叠 (UFO)

| 快捷键 | 功能 |
|--------|------|
| `zR` | 展开全部折叠 |
| `zM` | 折叠全部 |
| `K` | 预览折叠内容（或 LSP hover） |

---

## 插件清单

### 编辑增强
- **nvim-cmp** — 补全引擎，源：buffer / path / spell / luasnip / LSP
- **nvim-surround** — 快速添加/修改包围符号（括号、引号等）
- **nvim-autopairs** — 自动补全成对符号
- **repeat** — `.` 命令增强
- **endwise** — 自动补全 `end`（Ruby/Lua 等）
- **sleuth** — 自动检测缩进设置
- **lastplace** — 记住上次光标位置
- **ts-autotag** — 自动补全 HTML/XML 标签

### 语法与代码分析
- **treesitter** — 语法树高亮，支持 30+ 语言
- **rainbow-delimiters** — 括号彩虹配色
- **todo-comments** — TODO/FIXME/HACK 等高亮
- **indent-blankline** — 缩进参考线
- **colorizer** — 颜色值预览

### UI
- **lualine** — 状态栏，stylix 自动配色
- **noice** — 命令行/消息 UI 增强
- **bufferline** — 缓冲区标签栏
- **dashboard** — Alpha 启动页
- **which-key** — 快捷键引导提示
- **render-markdown** — Markdown 内联渲染
- **dressing** — 输入框 UI 优化
- **ufo** — 代码折叠（比原生更强）
- **aerial** — 代码大纲侧栏
- **trouble** — 诊断/引用/快速修复面板

### 文件与项目
- **neo-tree** — 文件树浏览器
- **mini.files** — 轻量级文件编辑
- **telescope** — 模糊搜索（fzf-native 加速）
- **project-nvim** — 项目管理
- **harpoon2** — 常用文件标记

### 工具
- **flash.nvim** — 快速跳转
- **toggleterm** — 内嵌终端
- **persistence** — 会话保存恢复
- **markdown-preview** — Markdown 浏览器预览

### Git
- **gitsigns** — 行级 Git 变更（Blame/Hunk/Diff）

### Mini 系列
- **mini.align** — 对齐文本
- **mini.files** — 轻量文件管理器
- **mini.hipatterns** — 高亮模式（hex 颜色等）
- **mini.indentscope** — 缩进作用域高亮
- **mini.move** — 移动行/选区 (`<C-h/j/k/l>`)

---

## 常用场景

### 场景 1：写 C++ 代码

```
1. <leader>ff         → 打开项目文件
2. 编辑代码，LSP 自动补全（Tab 选择）
3. <leader>cb         → g++ 编译
4. <leader>cr         → 编译并运行
5. <leader>ch         → 在 .cpp 和 .h 之间切换
6. gd                 → 跳转到函数定义
7. <leader>cR         → 重命名符号
8. <leader>ca         → Quick Fix（如添加 #include）
9. <F9>               → 设置断点
10. <F5>              → 开始调试
11. <leader>du        → 打开调试面板
```

### 场景 2：浏览大型项目

```
1. <leader>e          → 打开 Neo-tree 文件树
2. <leader>ff         → Telescope 模糊找文件
3. <leader>fg         → 全局搜索内容
4. <leader>cs         → Aerial 代码大纲
5. <leader>cw         → 搜索工作区符号
6. <leader>fp         → 切换项目
7. <leader>m1         → Harpoon 快速跳转常用文件
```

### 场景 3：Git 工作流

```
1. ]c / [c            → 浏览修改
2. <leader>hp         → 预览具体改动
3. <leader>hb         → 查看这行谁写的
4. <leader>hd         → 查看整个文件差异
5. <leader>hQ         → 所有变更收集到 Quickfix
```

### 场景 4：多窗口编辑

```
1. <A-s> (Telescope)  → 水平分屏打开文件
2. <A-v> (Telescope)  → 垂直分屏打开文件
3. <C-Left/Right>     → 调整窗口宽度
4. <leader>wH/L       → 移动窗口到左右
5. <leader>tt         → 打开终端
```

### 场景 5：Markdown 写作

```
1. <leader>ff         → 打开 .md 文件
2. 编辑，自动软换行（中文标点也作为换行点）
3. <leader>ce         → 查看诊断（拼写检查）
4. MarkdownPreview    → 浏览器预览（需手动执行）
```

---

## 如何自定义

### 添加插件

1. 在 `nixvim/` 下新建 `.nix` 文件，例如 `my-plugin.nix`：
```nix
{
  programs.nixvim.plugins.my-plugin.enable = true;
  programs.nixvim.plugins.my-plugin.settings = {
    option1 = "value";
  };
}
```

2. 在 `default.nix` 的 `imports` 中加入 `./my-plugin.nix`。

### 禁用插件

注释掉 `default.nix` 中对应的 import 行，或设置 `enable = false`。

### 修改快捷键

找到对应的 `.nix` 文件，修改 `keymaps` 列表。例如把 `<leader>ff` 改成 `<C-p>`：

```nix
# ui.nix 中
{
  key = "<C-p>";
  action = "<CMD>Telescope find_files ...<CR>";
  options = { silent = true; desc = "查找文件"; };
}
```

### 修改 LSP server 配置

编辑 `lsp.nix`，找到对应 server：

```nix
gopls = {
  enable = true;
  packageFallback = true;
  settings.gopls = {
    # 在这里改配置
    gofumpt = true;
  };
};
```

### 修改格式化器

编辑 `conform.nix`，在 `formatters_by_ft` 中添加或修改：

```nix
formatters_by_ft = {
  python = [ "ruff_fix" "ruff_format" ];
  # 添加新语言
};
```

### 添加新语言 LSP

编辑 `lsp.nix`，在 `servers` 中添加：

```nix
servers = {
  # 已有 servers...
  new_language_ls = {
    enable = true;
    packageFallback = true;
  };
};
```

---

## 构建命令

```bash
# 更新 nixvim 锁定版本
nix flake lock --update-input nixvim

# 应用配置
home-manager switch --flake .
```

---

## 注意事项

1. **样式由 stylix 管理**：主题颜色自动从 `stylix.colorscheme` 继承，无需手动设置。
2. **修改后须重新构建**：NixVim 不支持热重载，改完配置后运行 `home-manager switch --flake .`。
3. **fzf-native 加速**：Telescope 使用 fzf-native 进行模糊匹配，首次构建会自动编译。
4. **Nerd Font 必需**：图标依赖 Nerd Font，请确保终端字体已安装。
5. **Float 窗口透明**：弹窗（Telescope、Neo-tree 等）背景透明，由 `colorscheme.nix` 控制。
