{
  pkgs,
}:
let
  yp = pkgs.yaziPlugins;
in
{
  # ── UI / Beauty ──────────────────────────────────
  full-border = yp.full-border;
  yatline = yp.yatline;
  yatline-catppuccin = yp.yatline-catppuccin;
  yatline-githead = yp.yatline-githead;

  # ── Git ──────────────────────────────────────────
  git = yp.git;

  # ── Navigation ───────────────────────────────────
  smart-enter = yp.smart-enter;
  smart-filter = yp.smart-filter;
  smart-paste = yp.smart-paste;
  jump-to-char = yp.jump-to-char;
  relative-motions = yp.relative-motions;
  bookmarks = yp.bookmarks;
  bypass = yp.bypass;

  # ── Panel / Layout ───────────────────────────────
  toggle-pane = yp.toggle-pane;

  # ── File operations ──────────────────────────────
  wl-clipboard = yp.wl-clipboard;
  compress = yp.compress;
  diff = yp.diff;
  recycle-bin = yp.recycle-bin;

  # ── Previews ─────────────────────────────────────
  mime-ext = yp.mime-ext;
  mediainfo = yp.mediainfo;
  rich-preview = yp.rich-preview;
  glow = yp.glow;
  ouch = yp.ouch;
  office = yp.office;
}
