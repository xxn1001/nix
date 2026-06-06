{
  programs.nixvim.plugins.dashboard = {
    enable = true;
    settings = {
      change_to_vcs_root = true;
      theme = "doom";
      config = {
        header = [
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          " ██████╗ ██████╗  ██████╗ ██╗  ██╗"
          "██╔════╝██╔═══██╗██╔═══██╗██║ ██╔╝"
          "██║     ██║   ██║██║   ██║█████╔╝ "
          "██║     ██║   ██║██║   ██║██╔═██╗ "
          "╚██████╗╚██████╔╝╚██████╔╝██║  ██╗"
          " ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝"
          "┌────────────────────────────────┐"
          "|        Now, Say My Name.       |"
          "└────────────────────────────────┘"
          ""
          ""
        ];
        footer = [ "Life is a fucking movie. 人生如戏啊! 靓仔!" ];
        center = [
          {
            icon = " ";
            desc = "Files   ";
            action.__raw = "function(path) vim.cmd('ene | startinsert') end";
            group = "DiagnosticHint";
            key = "n";
          }
          {
            icon = " ";
            desc = "Find   ";
            action.__raw = "function(path) vim.cmd('Telescope find_files theme=dropdown previewer=false layout_config={height=0.3}') end";
            group = "Label";
            key = "f";
          }
          {
            icon = " ";
            desc = "Project   ";
            action.__raw = "function(path) vim.cmd('Telescope projects layout_config={height=0.6,width=0.6}') end";
            group = "Label";
            key = "p";
          }
          {
            icon = "󰒲 ";
            desc = "Session   ";
            action.__raw = ''
              function(path)
                local ok, _ = pcall(require, "persistence")
                if not ok then
                  vim.notify("persistence 未准备完毕", vim.log.levels.WARN, { title = "Todo" })
                  return nil
                end
                return require('persistence').load()
              end
            '';
            group = "Label";
            key = "s";
          }
          {
            icon = "󰈆 ";
            desc = "Exit   ";
            action.__raw = "function(path) vim.cmd('qa') end";
            group = "Number";
            key = "q";
          }
        ];
      };
    };
  };
}
