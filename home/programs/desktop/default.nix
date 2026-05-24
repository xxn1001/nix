{ inputs, pkgs, ... }:
{
  imports = [
    ./tofi.nix
    ./mako.nix
    ./niri
    ./fonts.nix
    ./noctalia.nix
  ];
  home.packages = with pkgs; [
    kanshi
    wlsunset
    xwayland-satellite
    wmname
  ];
  home.file."scripts" = {
    source = ./scripts;
    recursive = true;
  };
  home.sessionVariables.QT_QPA_PLATFORMTHEME = "gtk3";
  services.wl-clip-persist.enable = true;
}
