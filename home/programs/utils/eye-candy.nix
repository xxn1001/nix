{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    cmatrix
    cbonsai
  ];
  programs.fastfetch.enable = true;
  xdg.configFile."fastfetch/config.jsonc".source = ./fastfetch.jsonc;
  home.file.".face".source = ./face.png;
}
