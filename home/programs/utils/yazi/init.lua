require("git"):setup()

-- Yatline: beautiful status line & header
require("yatline"):setup({
  separator = {
    section_separator = { open = "", close = "" },
    part_separator = { open = "", close = "" },
    inverse_separator = { open = "", close = "" },
  },

  header_line = {
    left = {
      section_a = {
        { type = "line", custom = false, name = "tabs", params = { side = "left" } },
      },
      section_b = {},
      section_c = {},
    },
    right = {
      section_a = {
        { type = "string", custom = false, name = "tab_path", params = { trimmed = true, max_length = 30 } },
      },
      section_b = {},
      section_c = {},
    },
  },

  status_line = {
    left = {
      section_a = {
        { type = "coloreds", custom = false, name = "permissions" },
      },
      section_b = {
        { type = "string", custom = false, name = "hovered_name", params = { trimmed = true, max_length = 30 } },
      },
      section_c = {},
    },
    right = {
      section_a = {
        { type = "coloreds", custom = false, name = "count" },
      },
      section_b = {
        { type = "string", custom = false, name = "cursor_percentage" },
      },
      section_c = {
        { type = "string", custom = false, name = "cursor_position" },
      },
    },
  },
})

require("yatline-catppuccin"):setup()
require("yatline-githead"):setup()
