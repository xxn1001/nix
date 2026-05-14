{
  pkgs,
  config,
  inputs,
  ...
}:
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    enableFishIntegration = true;

    extraPackages = with pkgs; [
      bat
      glow
      mediainfo
      ouch
      miller
      exiftool
      poppler-utils
      p7zip
      libreoffice
    ];

    plugins = import ./plugins.nix { inherit pkgs; };
    settings = import ./settings.nix;
    theme = import ./theme.nix;
    keymap = import ./keymap.nix;
    initLua = ./init.lua;
  };
}
