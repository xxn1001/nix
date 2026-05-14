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
        run = "hx \"$@\"";
        desc = "Helix";
        block = true;
        for = "unix";
      }
    ];
    office = [
      {
        run = "libreoffice \"$@\"";
        desc = "LibreOffice";
        block = true;
        orphan = true;
        for = "unix";
      }
    ];
    play = [
      {
        run = "mpv \"$@\"";
        desc = "MPV";
        orphan = true;
        for = "unix";
      }
    ];
    open = [
      {
        run = "xdg-open \"$@\"";
        desc = "Open";
        for = "unix";
      }
    ];
  };

  open = {
    prepend_rules = [
      { name = "*.nix"; use = "edit"; }
      { name = "*.lua"; use = "edit"; }
      { name = "*.toml"; use = "edit"; }
      { name = "*.json"; use = "edit"; }
      { name = "*.yaml"; use = "edit"; }
      { name = "*.yml"; use = "edit"; }
      { name = "*.md"; use = "edit"; }
      { name = "*.mdx"; use = "edit"; }
      { name = "*.txt"; use = "edit"; }
      { name = "*.rs"; use = "edit"; }
      { name = "*.py"; use = "edit"; }
      { name = "*.go"; use = "edit"; }
      { name = "*.hs"; use = "edit"; }
      { name = "*.c"; use = "edit"; }
      { name = "*.h"; use = "edit"; }
      { name = "*.cpp"; use = "edit"; }
      { name = "*.hpp"; use = "edit"; }
      { name = "*.docx"; use = "office"; }
      { name = "*.doc"; use = "office"; }
      { name = "*.pptx"; use = "office"; }
      { name = "*.ppt"; use = "office"; }
      { name = "*.xlsx"; use = "office"; }
      { name = "*.xls"; use = "office"; }
      { name = "*.odt"; use = "office"; }
      { name = "*.ods"; use = "office"; }
      { name = "*.odp"; use = "office"; }
    ];
  };

  tasks = {
    micro_workers = 10;
    macro_workers = 10;
    bizarre_retry = 5;
  };
}
