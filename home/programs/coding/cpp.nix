{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnumake
    inotify-tools
    gdb
    lldb
    vscode-extensions.vadimcn.vscode-lldb
  ];
}
