{ user, ... }:
{
  networking = {
    bridges."general-br".interfaces = [ "tap" ];
    interfaces."general-br".ipv4.addresses = [
      {
        address = "172.16.8.1";
        prefixLength = 24;
      }
    ];

    interfaces."tap" = {
      virtual = true;
      virtualType = "tap";
      virtualOwner = "${user}";
    };

    nat = {
      enable = true;
      internalInterfaces = [ "general-br" ];
    };

    firewall.extraCommands = ''
        iptables -t nat -A POSTROUTING -s 172.16.8.0/24 ! -d 172.16.8.0/24 -j MASQUERADE
        iptables -A INPUT -i general-br -m state --state ESTABLISHED,RELATED -j ACCEPT
        iptables -A INPUT -i general-br -m state --state NEW -j DROP
      '';
  };
}
