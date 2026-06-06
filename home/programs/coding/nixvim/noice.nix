{
  programs.nixvim.plugins.noice.enable = true;
  programs.nixvim.plugins.notify = {
    enable = true;
    settings = {
      timeout = 2000;
      background_colour = "#000000";
    };
  };
  programs.nixvim.plugins.dressing.enable = true;
  programs.nixvim.plugins.noice.settings = {
    notify = {
      enabled = true;
      view = "notify";
    };
    lsp.signature.enabled = false;
    lsp.progress.enabled = false;
    lsp.hover.enabled = false;
  };
}
