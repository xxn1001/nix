{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xwayland
  ];
  
  programs.niri = {
    enable = true;
  };
}
