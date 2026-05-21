{ pkgs, ... }:
{
  home.packages = with pkgs; [
    delve
    gofumpt
    golangci-lint
  ];
}
