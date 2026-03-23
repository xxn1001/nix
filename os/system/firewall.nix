{ ... }:
{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
    allowPing = false;
    logRefusedConnections = true;
  };
}
