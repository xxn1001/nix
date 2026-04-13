{ pkgs, inputs, config, ... }:
let
  stable-pkgs = import inputs.nixpkgs-stable {
    system = pkgs.system;
    config = config.nixpkgs.config;
  };
in
{
  environment.systemPackages = [
    stable-pkgs.gvisor
  ];
  
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = false;
      extraPackages = [ stable-pkgs.gvisor ];
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers.backend = "podman";
  };
}
