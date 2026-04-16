{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    # 彻底移除可能导致警告的包装参数
    package = pkgs.vscode; 

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # 容器与基础架构
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        ms-kubernetes-tools.vscode-kubernetes-tools
        redhat.vscode-yaml
        # 开发辅助
        jnoortheen.nix-ide
        mkhl.direnv
        james-yu.latex-workshop
      ];

      userSettings = {
        "extensions.autoCheckUpdates" = false;
        "extensions.autoUpdate" = false;
        "settingsSync.ignoredSettings" = [];
        "workbench.settings.useSplitJSON" = true;
        "containers.containerClient" = "com.microsoft.visualstudio.containers.podman";
        "containers.orchestratorClient" = "com.microsoft.visualstudio.orchestrators.podmancompose";
        # "docker.dockerHost" = "unix:///run/user/1000/podman/podman.sock";
        "dev.containers.dockerPath" = "podman";
        "editor.lineNumbers" = "on";
        "editor.renderWhitespace" = "selection";
        "editor.minimap.enabled" = false;
        "workbench.startupEditor" = "none";
        "editor.formatOnSave" = true;
        # 彻底关闭遥测与 AI
        "telemetry.telemetryLevel" = "off";
        "update.mode" = "none";
        "github.copilot.enable" = { "*" = false; };
        "editor.inlineSuggest.enabled" = false;
      };
    };
  };
  stylix.targets.vscode.enable = true;
}
