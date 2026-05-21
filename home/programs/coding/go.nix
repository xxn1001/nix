{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gopls
    delve
    gofumpt
    golangci-lint
  ];
}
