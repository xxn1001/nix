{ inputs, pkgs, ... }:
{
  imports = [
    ./zathura.nix
  ];
  home.packages = with pkgs; [
    libreoffice
    # onlyoffice-desktopeditors
    evince
  ];

  xdg.mimeApps.defaultApplications = {
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "libreoffice-writer.desktop";
  };
}
