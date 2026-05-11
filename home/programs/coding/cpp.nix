{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnumake
    clang-tools
    inotify-tools
  ];
}
