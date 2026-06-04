{
  manager = {
    ratio = [ 1 3 4 ];
    sort_by = "alphabetical";
    sort_dir_first = true;
    show_hidden = false;
    show_symlink = true;
  };

  preview = {
    tab_size = 2;
    max_width = 1000;
    max_height = 800;
    cache_dir = "";
    image_filter = "lanczos3";
    image_quality = 90;
  };

  opener = {
    edit = [
      {
        run = "nvim %s";
        desc = "Neovim";
        block = true;
        for = "unix";
      }
    ];
    pdf = [
      {
        run = "zathura %s";
        desc = "Zathura";
        orphan = true;
        for = "unix";
      }
    ];
    office = [
      {
        run = "libreoffice %s 2>/dev/null";
        desc = "LibreOffice";
        block = true;
        orphan = true;
        for = "unix";
      }
    ];
    play = [
      {
        run = "mpv %s";
        desc = "MPV";
        orphan = true;
        for = "unix";
      }
    ];
    open = [
      {
        run = "xdg-open %s";
        desc = "Open";
        for = "unix";
      }
    ];
  };

  open = {
    prepend_rules = [
      { url = "*.nix"; use = "edit"; }
      { url = "*.lua"; use = "edit"; }
      { url = "*.toml"; use = "edit"; }
      { url = "*.json"; use = "edit"; }
      { url = "*.yaml"; use = "edit"; }
      { url = "*.yml"; use = "edit"; }
      { url = "*.md"; use = "edit"; }
      { url = "*.mdx"; use = "edit"; }
      { url = "*.txt"; use = "edit"; }
      { url = "*.rs"; use = "edit"; }
      { url = "*.py"; use = "edit"; }
      { url = "*.go"; use = "edit"; }
      { url = "*.hs"; use = "edit"; }
      { url = "*.c"; use = "edit"; }
      { url = "*.h"; use = "edit"; }
      { url = "*.cpp"; use = "edit"; }
      { url = "*.hpp"; use = "edit"; }
      { mime = "application/pdf"; use = "pdf"; }
      { url = "*.docx"; use = "office"; }
      { url = "*.doc"; use = "office"; }
      { url = "*.pptx"; use = "office"; }
      { url = "*.ppt"; use = "office"; }
      { url = "*.xlsx"; use = "office"; }
      { url = "*.xls"; use = "office"; }
      { url = "*.odt"; use = "office"; }
      { url = "*.ods"; use = "office"; }
      { url = "*.odp"; use = "office"; }
    ];
  };

  tasks = {
    micro_workers = 10;
    macro_workers = 10;
    bizarre_retry = 5;
  };
}
