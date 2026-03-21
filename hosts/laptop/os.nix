{ host, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];
  system.stateVersion = "23.11";
  networking.hostName = host;
}
