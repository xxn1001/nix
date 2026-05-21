# nixvim 使用指南

## 按键约定

- `<Leader>` = 空格键
- `<C-x>` = Ctrl+x
- `<F5>` 等 = 功能键

按 `<Leader>` 等待 which-key 弹出分组菜单，查看所有快捷键。

---

## LSP 代码智能

### 符号跳转

| 按键 | 功能 |
|------|------|
| `gd` | 跳转到定义 |
| `gD` | 跳转到声明 |
| `gr` | 查找引用 |
| `gI` | 跳转到实现 |
| `gy` | 跳转到类型定义 |
| `K` | 悬浮文档 (lspsaga) |
| `[` / `]` | 上一个/下一个诊断错误 |

### 代码操作 (lspsaga)

| 按键 | 功能 |
|------|------|
| `<Leader>lr` | 重命名符号 |
| `<Leader>la` | 代码动作 (自动修复/重构) |
| `<Leader>lo` | 大纲视图 |
| `<Leader>lf` | LSP 符号搜索 |
| `<Leader>lE` | 诊断详情浮窗 |

### 格式化

保存时自动格式化 (`conform-nvim`)。各语言的格式化器：

- **C/C++**: clang-format
- **Go**: gofumpt (更严格的 gofmt)
- **Python**: ruff
- **Nix**: nixfmt
- **Lua**: stylua
- **Bash**: shfmt + shellcheck + shellharden
- **Markdown/JSON/YAML/HTML/CSS**: prettier

---

## Telescope 搜索

| 按键 | 功能 |
|------|------|
| `<Leader>ff` | 按文件名搜索 |
| `<Leader>fb` | 搜索打开的 buffer |
| `<Leader>fd` | 搜索诊断错误 |
| `<Leader>fr` | 搜索寄存器内容 |

在 Telescope 窗口中：`<C-j>`/`<C-k>` 上下移动，`<CR>` 打开，`<C-t>` 在新 tab 打开。

---

## C/C++ 工作流

### 编译与运行

| 按键 | 功能 |
|------|------|
| `<Leader>cb` | 编译当前文件 (`g++ -std=c++20 -Wall -O2`) |
| `<Leader>cr` | 编译并运行 |
| `<Leader>ch` | 头文件/源文件切换 (.h ↔ .cpp) |

### clangd 特性

clangd 已配置以下参数，打开 `.c`/`.cpp` 文件后自动生效：

- **clang-tidy 诊断** — 保存时自动显示代码风格和潜在 bug
- **IWYU 头文件建议** — `#include` 缺少或多余时会提示，`<Leader>la` 自动修复
- **后台索引** — 跨文件跳转不卡顿
- **详细补全** — 函数参数签名、返回值类型一并展示

### 编译依赖

项目根目录需要 `compile_commands.json`，clangd 才能找到头文件路径：

```bash
# CMake 项目
cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ln -s build/compile_commands.json .

# Makefile 项目 (用 bear 抓取)
bear -- make
```

---

## Go 工作流

| 按键 | 功能 |
|------|------|
| `<Leader>gr` | `go run .` |
| `<Leader>gb` | `go build ./...` |
| `<Leader>gt` | `go test -v ./...` |

### gopls 特性

gopls 已启用以下增强：

- **gofumpt 格式化** — 比 gofmt 更严格（自动对齐字段、合并多行）
- **staticcheck** — 额外的静态分析（无用参数、不可达代码等）
- **类型提示** — 函数类型参数、复合字面量类型、常量值等都有 inlay hint

---

## 调试入门

### 概念

调试就是"让程序暂停在某个位置，检查变量的值，然后一步步往下走"。

三个核心概念：

| 术语 | 含义 | 类比 |
|------|------|------|
| **断点 (Breakpoint)** | 程序运行到这里就暂停 | 书签，但贴在哪行，程序就在哪行停 |
| **单步执行 (Step)** | 让程序执行一行，然后再次暂停 | 逐行审查代码 |
| **变量查看** | 暂停时看变量的值是否是你期望的 | printf 的高级替代 |

### 实战场景：Go 程序结果不对

假设你写了一个函数计算数组元素和，但结果总是错的：

```go
func Sum(nums []int) int {
    total := 0
    for i := 0; i <= len(nums); i++ {  // bug: 应该是 < 不是 <=
        total += nums[i]
    }
    return total
}
```

程序能编译运行，但结果不对或者 panic。怎么排查？

**不用调试器的排查方式**（你可能现在这样做的）：
1. 加 `fmt.Println(nums[i])` 看每次循环的值
2. 发现越界了
3. 改代码、再跑一遍
4. 每次改完都要重新编译

**用调试器的方式**：

1. **打断点** — 在 `total += nums[i]` 这一行按 `<F9>`，行号旁边出现红色圆点
2. **启动调试** — 确保当前文件是包含 `main()` 的那个，按 `<F5>`
3. **程序暂停** — 在断点处停下，此时 `<Leader>du` 打开调试面板
4. **查看变量** — 面板显示 `i=0, total=0, nums=[...]`
5. **单步执行** — 一遍遍按 `<F10>`，观察 `i` 的变化
6. **发现问题** — 当 `i=5`，数组只有 5 个元素(索引 0-4)，`nums[5]` 越界了
7. 修复：将 `<=` 改为 `<`

### 调试键位

| 按键 | 功能 |
|------|------|
| `<F9>` | 在当前行设置/取消断点 |
| `<F5>` | 开始调试 / 继续运行 |
| `<F10>` | 单步跳过（执行当前行，不进入函数内部） |
| `<F11>` | 单步进入（如果当前行有函数调用，进入函数内部调试） |
| `<F12>` | 单步跳出（执行完当前函数，回到调用方） |
| `<Leader>du` | 打开/关闭调试 UI 面板 |
| `<Leader>dt` | 打开/关闭调试 REPL（可在里面输入表达式求值） |

### 实战场景：C++ 段错误

```cpp
#include <vector>

int main() {
    std::vector<int> v = {1, 2, 3};
    int* p = &v[0];
    v.push_back(4);      // vector 扩容，p 指向的内存已被释放
    *p = 10;             // 段错误！p 是野指针
    return 0;
}
```

**调试步骤**：
1. 编译带调试符号：`g++ -std=c++20 -g -o test test.cpp`
2. 打开 `test.cpp`，调整配置中的 program 指向 `test`，或者在 main 处按 `<F9>` 打断点
3. 按 `<F5>` 启动调试
4. 单步执行 `<F10>`，观察 `p` 和 `v` 的变化
5. 在 `v.push_back(4)` 之后你会发现 `p` 的地址已经无效
6. 这种"用眼睛看到数据变化"比"脑内推理"可靠得多

> **提示**：C++ 调试依赖 `codelldb`（已安装）；Go 调试依赖 `delve`（已安装）。两个适配器在 `dap.nix` 中配置。

### 什么时候用调试器

- 结果和你预期不同，但看代码看不出问题
- 程序 crash（段错误 / panic），但不知道是哪一行
- 学习别人的代码，想跟踪执行流程
- 排查"偶尔出现"的 bug，需要观察运行时的值

**习惯建议**：养成习惯，遇到 bug 时先打断点看一眼变量，代替加 `printf` / `fmt.Println` 然后重新编译的循环。效率差 10 倍。

---

## 快速跳转

### Hop（任意位置跳转）

| 按键 | 功能 |
|------|------|
| `<Leader>hw` | 跳转到任意单词 |
| `<Leader>hl` | 跳转到任意行 |

按下后整个屏幕出现提示字符，输入对应的字符即可跳转。

### Mini 工具集

| 按键 | 功能 |
|------|------|
| `<Leader>o` | 文件浏览器 (MiniFiles) |
| `<Esc>` | 关闭 MiniFiles |
| `<C-h/j/k/l>` | 在可视模式下移动选中的行/块 |

---

## 缓冲区与窗口

| 按键 | 功能 |
|------|------|
| `S` | 保存 (`:w`) |
| `Q` | 关闭当前 buffer (`:bd`) |
| `<Leader>1-5` | 跳转到第 1-5 个 buffer (bufferline) |

---

## Markdown

`render-markdown.nvim` 在 buffer 内实时渲染标题、表格、代码块、数学公式。

数学公式支持：
- 行内：`$\alpha + \beta = \gamma$` 渲染为 α + β = γ
- 块级：`$$\int_0^\infty e^{-x} dx = 1$$` 渲染为对应公式

浏览器预览：`:MarkdownPreview` 在浏览器中打开渲染后的 HTML（需要 node 环境）。

---

## 配色与主题

- 配色完全由 Stylix 管理（`stylix.targets.nixvim.enable`），跟随系统主题
- 注释、布尔值、字符串均斜体显示，注释色调偏暗以便区分

---

## 配置位置速查

| 功能 | 文件 |
|------|------|
| 主配置 & 基础 keymap | `default.nix` |
| LSP + 格式化 + lspsaga | `lsp.nix` |
| 调试 (DAP) | `dap.nix` |
| 补全 (cmp) | `cmp.nix` |
| Treesitter 语法高亮 | `treesitter.nix` |
| UI 插件 (telescope/bufferline/which-key) | `ui.nix` |
| 状态栏 (lualine) | `lualine.nix` |
| Hop 跳转 | `hop.nix` |
| Mini 工具集 | `mini.nix` |
