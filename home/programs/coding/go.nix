{ pkgs, ... }:
{
  home.packages = with pkgs; [
    delve
    golangci-lint
  ];
}
