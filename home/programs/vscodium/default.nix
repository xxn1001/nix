{ ... }:
{
  imports = [
    ./vscodium.nix
    ./settings.nix
    ./extensions.nix
    ./keybinds.nix
  ];

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "codium.desktop";
    "text/x-csrc" = "codium.desktop";
    "application/x-shellscript" = "codium.desktop";
    "application/x-x509-ca-cert" = "codium.desktop";
  };
}
