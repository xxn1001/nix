{ pkgs, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      border-size = 4;
      border-radius = 8;
      default-timeout = 5000;
    };
  };
  stylix.targets.mako.enable = true;
  home.packages = [ pkgs.libnotify ];
}
