# Catppuccin Mocha
{
  manager = {
    cwd = { fg = "#89b4fa"; };
    hovered = { fg = "#cdd6f4"; bg = "#313244"; };
    preview_hovered = { fg = "#cdd6f4"; bg = "#45475a"; };
    find_keyword = { fg = "#f9e2af"; bg = "#1e1e2e"; bold = true; };
    find_position = { fg = "#f38ba8"; bg = "#1e1e2e"; bold = true; };
    border_idle = { fg = "#6c7086"; };
    border_hover = { fg = "#89b4fa"; };
    border_unknown = { fg = "#585b70"; };
  };

  status = {
    separator = "#45475a";
    mode_normal = { fg = "#1e1e2e"; bg = "#89b4fa"; bold = true; };
    mode_select = { fg = "#1e1e2e"; bg = "#a6e3a1"; bold = true; };
    mode_unset = { fg = "#1e1e2e"; bg = "#f9e2af"; bold = true; };
  };

  select = {
    border = { fg = "#cba6f7"; };
    active = { fg = "#f9e2af"; };
    inactive = { fg = "#6c7086"; };
  };

  input = {
    border = { fg = "#cba6f7"; };
    title = { fg = "#cdd6f4"; };
    value = { fg = "#cdd6f4"; };
    selected = { fg = "#1e1e2e"; bg = "#89b4fa"; };
  };

  completion = {
    border = { fg = "#cba6f7"; };
    active = { fg = "#f9e2af"; };
    inactive = { fg = "#6c7086"; };
  };

  tasks = {
    border = { fg = "#cba6f7"; };
    title = { fg = "#cdd6f4"; };
    hovered = { fg = "#cdd6f4"; bg = "#313244"; };
  };

  which = {
    mask = { bg = "#1e1e2e"; };
    cand = { fg = "#89b4fa"; };
    rest = { fg = "#6c7086"; };
    desc = { fg = "#a6adc8"; };
    separator = "#45475a";
  };

  help = {
    on = { fg = "#a6e3a1"; };
    run = { fg = "#89b4fa"; };
    desc = { fg = "#a6adc8"; };
    hovered = { fg = "#cdd6f4"; bg = "#313244"; };
    footer = { fg = "#6c7086"; };
  };

  filetype = {
    rules = [
      { mime = "image/*"; fg = "#94e2d5"; }
      { mime = "video/*"; fg = "#f5c2e7"; }
      { mime = "audio/*"; fg = "#f5c2e7"; }
      { mime = "application/x-bzip*"; fg = "#fab387"; }
      { mime = "application/x-compressed*"; fg = "#fab387"; }
      { name = "*.zip"; fg = "#fab387"; }
      { name = "*.tar*"; fg = "#fab387"; }
      { name = "*.gz"; fg = "#fab387"; }
      { name = "*.rar"; fg = "#fab387"; }
      { name = "*.7z"; fg = "#fab387"; }
      { name = "*.xz"; fg = "#fab387"; }
      { name = "*.nix"; fg = "#89b4fa"; }
      { name = "*.lua"; fg = "#89b4fa"; }
      { name = "*.toml"; fg = "#f9e2af"; }
      { name = "*.json"; fg = "#f9e2af"; }
      { name = "*.yaml"; fg = "#f9e2af"; }
      { name = "*.yml"; fg = "#f9e2af"; }
      { name = "*.md"; fg = "#f9e2af"; }
      { name = "*.mdx"; fg = "#f9e2af"; }
      { mime = "text/*"; fg = "#cdd6f4"; }
    ];
  };
}
