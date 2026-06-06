{ pkgs, ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = false;
      ensure_installed = [
        "bash" "fish" "python" "yaml" "lua" "json" "nix"
        "regex" "toml" "vim" "markdown" "markdown_inline" "jsonc"
        "glsl" "css" "scss" "html" "hyprlang"
        "c" "cpp" "rust"
        "go" "gomod" "gowork"
        "javascript" "typescript" "tsx"
        "latex" "typst"
        "cmake" "make" "dockerfile"
        "diff" "git_config" "gitignore"
        "sql" "graphql"
        "query"
      ];
      highlight.enable = true;
      indent.enable = true;
    };
  };
  programs.nixvim.plugins.hmts.enable = false;
  programs.nixvim.plugins.rainbow-delimiters.enable = true;
}
