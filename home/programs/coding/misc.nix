{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alejandra
    tree-sitter
    python3Packages.pylatexenc
  ];
}
