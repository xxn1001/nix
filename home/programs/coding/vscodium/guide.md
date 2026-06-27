# VSCodium + Neovim 交融指南

本配置通过 `vscode-neovim` 扩展在 VSCodium 内部嵌入真实 Neovim 内核，
**编辑走 Neovim，LSP/调试/补全走 VSCodium 原生**，两套体系用同一套键位统一操作。

---

## 架构：谁负责什么

```
┌────────────────────────── VSCodium ──────────────────────────┐
│  Explorer      Editor (Neovim 接管)      Terminal / Problems │
│  ┌──────────┐  ┌──────────────────────┐  ┌────────────────┐ │
│  │ 文件树   │  │  Neovim --embed      │  │  终端 / 问题   │ │
│  │ 搜索     │  │  ├ 编辑 (hjkl, i, v) │  │  Git 面板      │ │
│  │ Git      │  │  └ 插件 (surround..) │  │  Debug 面板    │ │
│  │ 扩展     │  └──────────────────────┘  └────────────────┘ │
│  └──────────┘                                                │
│                                                              │
│  ┌─ VSCodium 原生 ─────────────────────────────────────────┐ │
│  │ LSP 诊断波浪线 · 代码补全弹窗 · 函数签名 · 悬停文档    │ │
│  │ 重构 (F2 重命名) · Quick Fix · 格式化 · 调试断点      │ │
│  └─────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
```

| 层面 | 由谁处理 | 包含什么 |
|------|---------|---------|
| **文本编辑** | Neovim | 光标移动、插入删除、复制粘贴、撤销重做、文本对象、包围符号、宏录制 |
| **LSP 智能** | VSCodium | 诊断波浪线、自动补全、悬停文档、跳转定义、重命名、代码操作 |
| **文件导航** | VSCodium | 文件树、快速打开、全局搜索、标签页切换 |
| **Git** | VSCodium | diff 标注、blame、变更导航 |
| **调试** | VSCodium | 断点、单步执行、变量查看、调用栈 |
| **终端** | VSCodium | 集成终端、分屏 |
| **UI 布局** | VSCodium | 侧栏、面板、状态栏、命令面板 |

---

## 目录结构

```
home/programs/coding/vscodium/
├── default.nix            # 入口：imports 两个子模块
├── vscodium.nix           # VSCodium 主配置（扩展、设置、快捷键）
└── vscode-nvim.nix        # VSCode Neovim 精简配置（init.lua + 插件）
```

---

## 快捷键速查

> `<leader>` = 空格键  
> `[N]` = Neovim 原生命令  `[V]` = 桥接 VSCode 功能

### 基础编辑 [N]

| 快捷键 | 功能 | 等效 Vim 命令 |
|--------|------|-------------|
| `h` `j` `k` `l` | 光标移动 | |
| `w` `b` `e` | 按单词移动 | |
| `0` `$` `^` | 行首 / 行尾 / 首非空字符 | |
| `gg` `G` | 文件首 / 文件尾 | |
| `i` `a` `o` `O` | 进入插入模式 | |
| `Esc` / `Ctrl+[` | 回到 Normal 模式 | |
| `v` `V` `Ctrl+v` | 字符 / 行 / 块 可视模式 | |
| `dd` `yy` `x` | 删除行 / 复制行 / 删除字符 | |
| `p` `P` | 粘贴到光标后 / 前 | |
| `u` `Ctrl+r` | 撤销 / 重做 | |
| `/{pattern}` `?{pattern}` | 向下 / 向上搜索 | |
| `n` `N` | 下一个 / 上一个匹配项 | |
| `:%s/old/new/g` | 全局替换 | |
| `>>` `<<` | 增加 / 减少缩进 | |
| `=` (visual) | 自动缩进 | |
| `gg=G` | 全文自动格式化缩进 | |

### 搜索与替换技巧 [N]

| 操作 | 按键 | 说明 |
|------|------|------|
| 搜索光标下单词 | `*` / `#` | 向下 / 向上 |
| 选中后搜索 | visual 选中 → `*` | |
| 替换前确认 | `:%s/old/new/gc` | `c` 表示每次确认 |
| 替换选中区域 | visual 选中 → `:'<,'>s/old/new/g` | |
| 大小写不敏感搜索 | `/\cpattern` | |

### 文本对象 [N]

| 操作 | 按键示例 | 说明 |
|------|---------|------|
| 修改单词 | `ciw` | change inner word |
| 修改引号内 | `ci"` `ci'` | change inner quotes |
| 修改括号内 | `ci(` `ci[` `ci{` | change inner brackets |
| 修改标签内 | `cit` | change inner tag (HTML/XML) |
| 删除段落 | `dap` | delete around paragraph |
| 选择整个函数 | `vaf` / `vif` | 需 treesitter (仅 Neovide) |
| 修改到行尾 | `C` | change to end of line |
| 修改到行首 | `c0` / `c^` | |

### 包围符号 [N]（nvim-surround）

| 操作 | 按键 | 说明 |
|------|------|------|
| 添加包围 | `ysiw"` | 光标词加上 `"` |
| 添加包围（整行） | `yss)` | 整行加 `()` |
| 修改包围 | `cs"'` | `"` 变 `'` |
| 修改包围 | `cs'(` | `'` 变 `(` (自动加空格) |
| 修改包围 | `cs({` | `(` 变 `{` |
| 删除包围 | `ds"` | 删除最近的 `"` |
| 删除包围 | `ds(` | 删除最近的 `()` |
| Visual 模式添加 | `S"` | 选中文本加 `"` |

### 注释 [N]（mini.comment）

| 快捷键 | 功能 |
|--------|------|
| `gcc` | 切换当前行注释 |
| `gc` + motion | 按 motion 切换注释 |
| `gc` + visual | 切换选中区域注释 |
| `gcj` / `gck` | 注释当前行 + 下一行 / 上一行 |

### 多行编辑技巧 [N]

| 操作 | 按键 |
|------|------|
| 块选中 | `Ctrl+v` 进入块可视模式 |
| 多行插入相同文本 | `Ctrl+v` → `j` 选多行 → `I` → 输入文本 → `Esc` |
| 多行追加文本 | `Ctrl+v` → `j` 选多行 → `$` → `A` → 输入文本 → `Esc` |
| 递增数字 | `Ctrl+a`（光标在数字上） |
| 递减数字 | `Ctrl+x` |

### 保存与缓冲 [N]

| 快捷键 | 功能 |
|--------|------|
| `<C-s>` | 保存当前文件 |
| `Q` | 关闭当前缓冲 |
| `<leader>bn` | 下一个缓冲区 |
| `<leader>bp` | 上一个缓冲区 |

---

### LSP 智能操作 [V]

| 快捷键 | VSCode 命令 | 功能 |
|--------|-----------|------|
| `gd` | `editor.action.revealDefinition` | 跳转到定义 |
| `gr` | `references-view.findReferences` | 查找全部引用 |
| `gD` | `editor.action.revealDeclaration` | 跳转到声明 |
| `gI` | `editor.action.goToImplementation` | 查找接口实现 |
| `gt` | `editor.action.goToTypeDefinition` | 跳转到类型定义 |
| `K` | `editor.action.showHover` | 显示悬停文档 / 类型签名 |
| `<leader>cR` | `editor.action.rename` | 重命名符号 (F2) |
| `<leader>ca` | `editor.action.quickFix` | 代码操作 / Quick Fix |
| `<leader>cf` | `workbench.action.gotoSymbol` | 当前文件大纲 |
| `<leader>cw` | `workbench.action.showAllSymbols` | 工作区符号搜索 |
| `<leader>ci` | `editor.action.goToImplementation` | 查找实现 (Telescope 风格) |
| `<leader>cG` | `references-view.findReferences` | 查找引用 (Telescope 风格) |
| `[d` | `editor.action.marker.prev` | 上一个诊断 |
| `]d` | `editor.action.marker.next` | 下一个诊断 |
| `<leader>ce` | `workbench.action.showErrorsWarnings` | 当前文件诊断浮动窗 |
| `<leader>cW` | `workbench.panel.markers.view.focus` | 全局诊断面板 |
| `<leader>cd` | `editor.action.peekProblem` | 查看当前行问题详情 |

> **注意**：`K` 在 VSCodium 中显示悬停文档（类型签名、参数说明等），
> 这与 Neovide 中 UFO 折叠预览 + LSP hover 的行为不同，但功能更丰富。

---

### 文件 / 搜索 / UI [V]

| 快捷键 | VSCode 命令 | 功能 |
|--------|-----------|------|
| `<leader>ff` | `workbench.action.quickOpen` | 快速打开文件 (Ctrl+P) |
| `<leader>fg` | `workbench.action.findInFiles` | 全局内容搜索 (Ctrl+Shift+F) |
| `<leader>fs` | `workbench.action.findInFiles` | 搜索选中文本 |
| `<leader>fb` | `workbench.action.showAllEditors` | 查看所有编辑器 |
| `<leader>fo` | `workbench.action.openRecent` | 最近打开的文件/项目 |
| `<leader>fp` | `workbench.action.openRecent` | 切换项目 |
| `<leader>fk` | `workbench.action.openGlobalKeybindings` | 查看快捷键列表 |
| `<leader>e` | `workbench.view.explorer` | 打开/关闭文件树 (Ctrl+B) |

> **`<leader>ff` 内的操作技巧**：
> - 输入 `@` 跳转到符号，`:` 跳转到行号，`>` 跳转到编辑器组
> - 输入文件名片段即可模糊匹配
> - `Alt+Enter` 在侧边打开而不关闭面板

---

### 终端 [V]

| 快捷键 | VSCode 命令 | 功能 |
|--------|-----------|------|
| `<leader>tt` | `workbench.action.terminal.toggle` | 打开/关闭终端 |
| `<leader>tv` | `workbench.action.terminal.split` | 分屏新终端 |
| `<leader>th` | `workbench.action.terminal.split` | 分屏新终端 |

> **终端内切换回编辑区**：`Ctrl+1` 聚焦编辑器组1，`Ctrl+`` 切换回终端

---

### 诊断与问题面板 [V]

| 快捷键 | VSCode 命令 | 功能 |
|--------|-----------|------|
| `<leader>xx` | `workbench.actions.view.problems` | 切换问题面板 |
| `<leader>xX` | `workbench.panel.markers.view.focus` | 当前文件问题 |

---

### Git [V]

| 快捷键 | VSCode 命令 | 功能 |
|--------|-----------|------|
| `]c` | `editor.action.dirtydiff.next` | 下一个修改块 |
| `[c` | `editor.action.dirtydiff.previous` | 上一个修改块 |
| `<leader>hp` | `git.openChange` | 预览当前 Hunk 差异 |
| `<leader>hb` | `git.toggleBlame` | 行内 Blame 注释 |
| `<leader>hd` | `git.openChange` | 显示文件整体差异 |
| `<leader>ht` | `git.toggleBlame` | 切换行内 Blame |

> **更完整的 Git 操作**：`Ctrl+Shift+G` 打开 Git 面板，可 stage/unstage/commit 等

---

### 标签页管理 [V]

| 快捷键 | VSCode 命令 | 功能 |
|--------|-----------|------|
| `<leader><tab><tab>` | `workbench.action.newGroupBelow` | 新建编辑器组 |
| `<leader><tab>d` | `workbench.action.closeActiveEditor` | 关闭当前编辑器 (Ctrl+W) |
| `<leader><tab>l` | `workbench.action.nextEditor` | 下一个编辑器 (Ctrl+Tab) |
| `<leader><tab>h` | `workbench.action.previousEditor` | 上一个编辑器 (Ctrl+Shift+Tab) |

---

### 命令面板与快捷键 [V]

| 快捷键 | VSCode 命令 | 功能 |
|--------|-----------|------|
| `<leader>:` | `workbench.action.showCommands` | VSCode 命令面板 |
| `:` | Neovim 命令行 | `:w` `:q` `:e file` 等 |

> `<leader>:` = **空格 + 冒号**（300ms 内按下）打开 VSCode 命令面板  
> 单独按 `:` 打开 Neovim 命令行（用于 `:w`、`:q`、`:%s/...` 等）

---

### 窗口与编辑器组 [VSCode 原生]

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+\` | 拆分编辑器 |
| `Ctrl+1/2/3/4` | 聚焦第 N 个编辑器组 |
| `Ctrl+Shift+1/2/3` | 按第 N 列布局 |
| `Ctrl+K Ctrl+\` | 横向拆分 |
| `Ctrl+W` | 关闭当前编辑器 |
| `Ctrl+K Ctrl+W` | 关闭所有编辑器 |

---

### 调试 [VSCode 原生]

| 快捷键 | 功能 |
|--------|------|
| `F5` | 启动调试 / 继续 |
| `Shift+F5` | 停止调试 |
| `F9` | 切换断点 |
| `F10` | 单步跳过 |
| `F11` | 单步进入 |
| `Shift+F11` | 单步跳出 |
| `Ctrl+Shift+D` | 打开调试面板 |

---

## 常用场景

### 场景 1：写 Python 代码

```
1. <leader>ff         → 快速打开 .py 文件
2. 编辑代码           → Normal 模式 hjkl w b e + Insert 模式输入
3. K                  → 查看函数签名 / 文档
4. gd                 → 跳转到函数/类定义
5. gr                 → 查看所有引用位置
6. <leader>cR         → 重命名变量/函数
7. <leader>ca         → Quick Fix（自动导入、添加类型注解等）
8. [d / ]d            → 逐个浏览诊断（lint 错误）
9. gcc                → 注释当前行
10. <leader>tt        → 打开终端，运行 python 或 pytest
11. F5                 → 调试模式运行（需配置 launch.json）
12. F9                 → 切换断点，F10/F11 单步调试
```

### 场景 2：写 C++ 代码

```
1. <leader>ff         → 打开 .cpp 或 .h 文件
2. 编辑代码           → 智能补全由 clangd 提供（Pylance 等价）
3. gd                 → 跳转到函数定义
4. gI                 → 跳转到虚函数实现
5. <leader>cR         → 重命名符号
6. <leader>ca         → Quick Fix（如添加缺少的 #include）
7. [d / ]d            → 诊断导航（编译错误/警告）
8. gcc                → 注释当前行
9. <leader>tt         → 打开终端，cmake / make / run
10. F5                → 启动 GDB 调试（需 C/C++ launch.json）
```

### 场景 3：浏览大型项目

```
1. <leader>e          → 打开文件树，浏览目录结构
2. <leader>ff         → 快速打开已知文件名
3. <leader>fg         → 全局搜索函数名/类名/字符串
4. <leader>cf         → 当前文件大纲（Ctrl+Shift+O），快速定位函数
5. <leader>cw         → 工作区符号搜索（Ctrl+T），跨文件找类/函数
6. gd / gr            → 沿着调用链跳转
7. <leader>fo         → 在最近文件间切换
8. <leader><tab>l/h   → 在打开的编辑器间切 tab
```

### 场景 4：Git 工作流

```
1. ]c / [c            → 浏览当前文件的修改块
2. <leader>hp         → 查看某个修改块的具体 diff
3. <leader>hb         → 查看当前行最后是谁改的
4. Ctrl+Shift+G       → 打开 Git 面板（stage/unstage/commit）
5. <leader>tt         → 打开终端，git 命令操作
```

### 场景 5：Jupyter Notebook

```
1. <leader>ff         → 打开 .ipynb 文件
2. Shift+Enter        → 执行当前 Cell 并移到下一个
3. Ctrl+Enter         → 执行当前 Cell
4. a / b              → 在上方/下方插入 Cell（Jupyter 扩展默认快捷键）
5. dd                 → 删除 Cell（Jupyter 扩展快捷键）
6. m / y              → 切换 Markdown / Code 模式
7. Esc                → 从编辑模式退出到 Cell 导航模式
```

### 场景 6：重构代码

```
1. <leader>cR         → 重命名符号（所有引用同步更新）
2. <leader>ca         → 查看可用的代码操作
3. gc (visual)        → 注释选中区域
4. <leader>fg         → 搜索所有引用位置，逐一确认
5. = (visual)         → 自动格式化缩进
6. :%s/old/new/g      → 全局替换（Neovim 命令行）
```

### 场景 7：写 Markdown

```
1. <leader>ff         → 打开 .md 文件
2. 编辑               → 自动软换行、中文标点换行
3. Ctrl+Shift+V       → 打开 Markdown 预览
4. <leader>ce         → 诊断（拼写检查、Markdown lint）
5. <leader>ss         → 切换拼写检查
```

---

## VSCodium 原生快捷键（保留不变）

以下快捷键仍然由 VSCodium 直接处理，不受 Neovim 影响：

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+Shift+P` | 命令面板 |
| `Ctrl+P` | 快速打开文件 |
| `Ctrl+Shift+F` | 全局搜索 |
| `Ctrl+Shift+G` | Git 面板 |
| `Ctrl+Shift+D` | 调试面板 |
| `Ctrl+Shift+X` | 扩展面板 |
| `Ctrl+B` | 切换侧边栏 |
| `Ctrl+J` | 切换底部面板 |
| `Ctrl+`` | 切换终端 |
| `Ctrl+,` | 打开设置 |
| `Ctrl+K Ctrl+S` | 快捷键设置 |
| `Ctrl+Shift+Tab` | 上一个编辑器 |
| `Ctrl+Tab` | 下一个编辑器 |
| `Ctrl+\` | 拆分编辑器 |
| `Ctrl+W` | 关闭编辑器 |
| `Ctrl+D` | 选择下一个相同词 |
| `Ctrl+Shift+L` | 选择所有相同词 |
| `Alt+Up/Down` | 移动行 |
| `F12` | 跳转到定义 |

---

## 常用 Vim 命令行速查

通过 `:` 直接进入 Neovim 命令行（非命令面板）：

| 命令 | 功能 |
|------|------|
| `:w` | 保存文件 |
| `:q` | 关闭 |
| `:wq` / `:x` | 保存并关闭 |
| `:e file` | 打开文件 |
| `:e!` | 放弃修改重新加载 |
| `:%s/old/new/g` | 全文替换 |
| `:10,20s/old/new/g` | 10-20 行替换 |
| `:set nu!` | 切换行号 |
| `:set spell!` | 切换拼写检查 |
| `:noh` | 清除搜索高亮 |
| `:reg` | 查看寄存器列表 |
| `:marks` | 查看标记列表 |
| `:buffers` | 查看缓冲区列表 |
| `:help topic` | 打开帮助（不推荐在 VSCode 中用） |

---

## 配置修改指南

### 添加 VSCodium 扩展

编辑 `vscodium/vscodium.nix`，在 `extensions` 列表中添加：

```nix
extensions = with pkgs.vscode-extensions; [
  # 已有扩展...
  publisher-name.extension-name  # ← 添加新扩展
];
```

### 修改 VSCodium 设置

编辑 `vscodium/vscodium.nix`，在 `userSettings` 中添加键值对：

```nix
userSettings = {
  # 已有设置...
  "python.formatting.provider" = "none";  # 由 Ruff 处理格式化
};
```

### 修改 VSCode Neovim 快捷键

编辑 `vscodium/vscode-nvim.nix`，在 init.lua 中找到对应映射：

```lua
-- 例如：把 <leader>ff 改成 <C-p>
vsc_map("n", "<C-p>", "workbench.action.quickOpen", "查找文件")
```

### 添加 Neovim 编辑插件

1. 在 `vscodium/vscode-nvim.nix` 的 `plugins` 列表中添加插件：

```nix
plugins = with pkgs.vimPlugins; [
  nvim-surround
  nvim-autopairs
  vim-sleuth
  # 添加新插件 ↓
  vim-commentary
];
```

2. 在 init.lua 中添加对应的 `setup()` 调用：

```lua
pcall(function() require("Comment").setup({}) end)
```

### 重新构建

```bash
home-manager switch --flake .
```

> **注意**：修改 VSCodium 设置后无需重启整个系统。可以在 VSCodium 中按
> `Ctrl+Shift+P` → `Developer: Reload Window` 快速重载。

---

## 注意事项

1. **Alt 键可能不生效**：VSCodium 可能拦截 `Alt` 组合键（如 `<A-j>` 行移动）。
   如果 `<A-j> / <A-k>` 没反应，改用 `Alt+Up/Down`（VSCodium 原生）或 `:m .+1`。

2. **Ctrl+s 保存**：VSCodium 的 `ctrl+s` 键绑定（无 when 条件）优先拦截，
   执行 `workbench.action.files.saveFiles`。Neovim 的 `:w` 一般不会被调用。

3. **补全由 VSCodium 管理**：当补全弹窗出现时，`Tab` / `Shift+Tab` 选择候选项
   （vscodium.nix 中已配置），这些按键由 VSCodium 拦截，不传给 Neovim。

4. **Neovim 不处理配色**：视觉主题由 VSCodium 控制（`workbench.colorTheme` =
   `Gruvbox Light Soft`，由 stylix 管理）。Neovim 运行在无头模式下，colorscheme 不影响显示。

5. **Neovide vs VSCodium 分离**：
   - Neovide 用完整 nixvim 配置（`~/.config/nvim/init.lua`），所有插件激活
   - VSCodium 用精简配置（`~/.config/nvim-vscode/init.lua`），仅编辑插件激活
   - 两者互不干扰，状态文件也隔离（`nvim-vscode` 使用独立的 `shada`、`undo` 文件）

6. **VSCode Neovim 重启**：如果 Neovim 出问题，`Ctrl+Shift+P` →
   `Neovim: Restart` 重启 Neovim 进程。
