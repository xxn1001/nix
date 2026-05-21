{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alejandra
    nixfmt
    prettier
    tree-sitter
    python3Packages.pylatexenc
  ];
}
