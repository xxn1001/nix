{
  pkgs,
  lib,
  inputs,
  host,
  user,
  ...
}:
let
  nixd = inputs.nixd.packages.${pkgs.stdenv.hostPlatform.system}.nixd;
in
{
  home.packages = with pkgs; [
    python3
    # Python
    ruff
    pyright
    # C/C++
    clang-tools
    cmake-language-server
    # Go
    gopls
    gofumpt
    # Lua
    lua-language-server
    stylua
    # Nix
    nixd
    nixfmt
    # LaTeX
    texlab
    # Markdown / Web
    marksman
    prettier
    # Bash
    shfmt
    shellcheck
    shellharden
    bash-language-server
    # YAML / JSON
    yamlfmt
    yaml-language-server
  ];

  programs.helix.extraPackages = with pkgs; [
    ruff
    pyright
    clang-tools
    cmake-language-server
    gopls
    lua-language-server
    nixd
    texlab
    marksman
    bash-language-server
    yaml-language-server
    nixfmt
  ];
}
