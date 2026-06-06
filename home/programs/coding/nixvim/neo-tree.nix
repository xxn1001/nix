{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      settings = {
        window = {
          width = 30;
          mappings."<space>" = "none";
        };
        add_blank_line_at_top = false;
        filesystem = {
          bind_to_cwd = false;
          follow_current_file = {
            enabled = true;
            leave_dirs_open = true;
          };
          group_empty_dirs = true;
          hijack_netrw = true;
        };
        default_component_configs = {
          indent = {
            with_expanders = true;
            expander_collapsed = "󰅂";
            expander_expanded = "󰅀";
            expander_highlight = "NeoTreeExpander";
          };
          git_status.symbols = {
            added = "";
            modified = "";
            deleted = "󱂥";
            renamed = "󰑕";
            untracked = "";
            unstaged = "";
            staged = "󰩍";
            ignored = "";
            conflict = "";
          };
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle reveal_force_cwd<cr>";
        options = { silent = true; desc = "打开/关闭文件树"; };
      }
    ];
  };
}
