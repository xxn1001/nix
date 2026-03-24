{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kubectl            # 官方 K8s 客户端
    kubernetes-helm    # 包管理
    kind               # K8s 模拟器
    k9s                # (额外推荐) 终端里的 K8s UI，非常适合监控集群状态
  ];

  # 环境变量：确保 kind 始终看向 podman
  home.sessionVariables = {
    KIND_EXPERIMENTAL_PROVIDER = "podman";
  };

  # 别名：为了你 ML 开发时的效率
  home.shellAliases = {
    k   = "kubectl";
    kgp = "kubectl get pods";
    kdp = "kubectl describe pod";
    kl  = "kubectl logs -f";
  };
}
