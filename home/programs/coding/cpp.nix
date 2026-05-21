{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnumake
    clang-tools
    inotify-tools
    cmake-language-server
    gdb
    lldb
    vscode-extensions.vadimcn.vscode-lldb
  ];
}
