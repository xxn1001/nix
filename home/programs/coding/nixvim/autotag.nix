{
  programs.nixvim.plugins.ts-autotag = {
    enable = true;
    settings.opts = {
      enable_close = false;
      enable_close_on_slash = false;
      enable_rename = true;
    };
  };
}
