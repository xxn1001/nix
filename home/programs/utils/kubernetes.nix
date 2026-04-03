{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kubectl            # 官方 K8s 客户端
    kubernetes-helm    # 包管理
    kind               # K8s 模拟器
    k9s                # (额外推荐) 终端里的 K8s UI，非常适合监控集群状态
    kustomize
    kubecolor
    stern
    kubectx
    popeye
  ];

  home.sessionVariables = {
    KIND_EXPERIMENTAL_PROVIDER = "podman";
  };

  home.shellAliases = {
    k   = "kubecolor";
    kg  = "kubecolor get";
    kgp = "kubecolor get pods";
    kgs = "kubecolor get svc";
    kdp = "kubecolor describe pod";
    kl  = "kubecolor logs -f";
    ka  = "kubecolor apply -f";

    kn = "kubens";
    kx = "kubectx";

    sl = "stern";

    h   = "helm";
  };
}
