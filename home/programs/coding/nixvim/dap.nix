{ pkgs, lib, ... }:
let
  codelldb = pkgs.vscode-extensions.vadimcn.vscode-lldb;
in
{
  programs.nixvim.plugins = {
    dap = {
      enable = true;

      adapters.servers = {
        codelldb = {
          host = "127.0.0.1";
          port = "\${port}";
          executable = {
            command = "${codelldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
            args = [ "--port" "\${port}" ];
          };
        };
        delve = {
          host = "127.0.0.1";
          port = "\${port}";
          executable = {
            command = lib.getExe pkgs.delve;
            args = [
              "dap"
              "-l"
              "127.0.0.1:\${port}"
            ];
          };
        };
      };

      configurations = {
        c = [
          {
            name = "Launch (codelldb)";
            type = "codelldb";
            request = "launch";
            program = "\${fileDirname}/\${fileBasenameNoExtension}";
            cwd = "\${workspaceFolder}";
            stopOnEntry = false;
          }
        ];
        cpp = [
          {
            name = "Launch (codelldb)";
            type = "codelldb";
            request = "launch";
            program = "\${fileDirname}/\${fileBasenameNoExtension}";
            cwd = "\${workspaceFolder}";
            stopOnEntry = false;
          }
        ];
        go = [
          {
            name = "Debug Go";
            type = "delve";
            request = "launch";
            program = "\${file}";
          }
        ];
      };
    };
    dap-ui.enable = true;
    dap-virtual-text.enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<F5>";
      action = "<cmd>lua require('dap').continue()<CR>";
    }
    {
      mode = "n";
      key = "<F9>";
      action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
    }
    {
      mode = "n";
      key = "<F10>";
      action = "<cmd>lua require('dap').step_over()<CR>";
    }
    {
      mode = "n";
      key = "<F11>";
      action = "<cmd>lua require('dap').step_into()<CR>";
    }
    {
      mode = "n";
      key = "<F12>";
      action = "<cmd>lua require('dap').step_out()<CR>";
    }
    {
      mode = "n";
      key = "<Leader>du";
      action = "<cmd>lua require('dapui').toggle()<CR>";
    }
    {
      mode = "n";
      key = "<Leader>dt";
      action = "<cmd>lua require('dap').repl.toggle()<CR>";
    }
  ];
}
