{ ... }:
{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
    allowPing = false;
    logRefusedConnections = true;
  };
}
