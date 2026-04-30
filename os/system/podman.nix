{ pkgs, stable-pkgs, ... }:
{
  # environment.systemPackages = [
  #   stable-pkgs.gvisor
  # ];
  
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = false;
      # extraPackages = [ stable-pkgs.gvisor ];
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers.backend = "podman";
  };
}
