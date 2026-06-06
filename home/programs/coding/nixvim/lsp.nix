{
  pkgs,
  lib,
  inputs,
  host,
  user,
  ...
}:
{
  programs.nixvim.lsp.inlayHints.enable = true;
  programs.nixvim.plugins.lsp = {
    enable = true;
    keymaps = {
      diagnostic = {
        "[" = "goto_prev";
        "]" = "goto_next";
      };
      lspBuf = {
        "gD" = "declaration";
        "gd" = "definition";
        "gr" = "references";
        "gI" = "implementation";
        "gt" = "type_definition";
      };
    };
    servers = {
      clangd = {
        enable = true;
        packageFallback = true;
        cmd = [
          "clangd"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=iwyu"
          "--function-arg-placeholders=false"
        ];
      };
      cmake = {
        enable = true;
        packageFallback = true;
      };
      rust_analyzer = {
        enable = true;
        packageFallback = true;
        installCargo = false;
        installRustc = false;
        settings = {
          check.command = "clippy";
          checkOnSave = true;
          inlayHints = {
            typeHints = true;
            parameterHints = true;
            chainingHints = true;
          };
        };
      };
      ts_ls = {
        enable = true;
        packageFallback = true;
      };
      basedpyright = {
        enable = true;
        packageFallback = true;
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard";
              autoSearchPaths = true;
              useLibraryCodeForTypes = true;
              diagnosticMode = "openFilesOnly";
            };
          };
        };
      };
      ruff = {
        enable = true;
        packageFallback = true;
      };
      lua_ls = {
        enable = true;
        settings = {
          Lua = {
            diagnostics.globals = [ "vim" ];
            hint.enable = false;
          };
        };
      };
      gopls = {
        enable = true;
        packageFallback = true;
        settings.gopls = {
          gofumpt = true;
          hints = {
            assignVariableTypes = true;
            compositeLiteralFields = true;
            compositeLiteralTypes = true;
            constantValues = true;
            functionTypeParameters = true;
            parameterNames = true;
            rangeVariableTypes = true;
          };
          analyses = { unusedparams = true; unreachable = true; unusedvariable = true; };
          staticcheck = true;
        };
      };
      bashls.enable = true;
      nixd = {
        enable = true;
        package = inputs.nixd.packages.${pkgs.stdenv.hostPlatform.system}.nixd;
        settings = {
          formatting.command = [ "nixfmt" ];
          nixd.nixpkgs.expr = "import ${inputs.nixpkgs} { }";
          options =
            let flake = ''(builtins.getFlake "/home/${user}/nix")'';
            in {
              nixos.expr = "${flake}.nixosConfigurations.${host}.options";
              home_manager.expr = ''${flake}.homeConfigurations."${user}@${host}".options'';
            };
        };
      };
      html.enable = true;
      cssls.enable = true;
      tailwindcss.enable = true;
      emmet_ls.enable = true;
      eslint = {
        enable = true;
        packageFallback = true;
      };
      texlab.enable = true;
      tinymist.enable = true;
      jsonls.enable = true;
      taplo.enable = true;
      marksman.enable = true;
      yamlls = {
        enable = true;
        settings = {
          yaml = {
            schemas = {
              "https://json.schemastore.org/github-workflow" = ".github/workflows/*";
              "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" = [ "docker-compose.{yml,yaml}" "*compose*.{yml,yaml}" ];
            };
          };
        };
      };
      qmlls = { enable = true; filetypes = [ "qml" ]; };
      harper_ls.enable = true;
    };
  };
  programs.nixvim.keymaps = [
    {
      key = "<leader>ci";
      action = "<cmd>Telescope lsp_implementations<cr>";
      options.desc = "查找实现";
    }
    {
      key = "<leader>cG";
      action = "<cmd>Telescope lsp_references<cr>";
      options.desc = "查找引用";
    }
    {
      key = "<leader>cw";
      action = "<cmd>Telescope lsp_workspace_symbols<cr>";
      options.desc = "查找工作区符号";
    }
    {
      key = "<leader>cf";
      action = "<cmd>Telescope lsp_document_symbols<cr>";
      options.desc = "文件大纲";
    }
    {
      key = "<leader>c[";
      action = "<cmd>Telescope lsp_incoming_calls<cr>";
      options.desc = "被调列表";
    }
    {
      key = "<leader>c]";
      action = "<cmd>Telescope lsp_outgoing_calls<cr>";
      options.desc = "调用列表";
    }
    {
      key = "<leader>ce";
      action = "<cmd>Telescope diagnostics bufnr=0<cr>";
      options.desc = "当前文件诊断";
    }
    {
      key = "<leader>cW";
      action = "<cmd>Telescope diagnostics<cr>";
      options.desc = "全局诊断";
    }
    {
      key = "<leader>cd";
      action = "<cmd>lua vim.diagnostic.open_float()<cr>";
      options.desc = "打开当前行诊断浮窗";
    }
    {
      key = "<leader>cR";
      action = "<cmd>lua vim.lsp.buf.rename()<cr>";
      options.desc = "重命名符号";
    }
    {
      key = "<leader>ca";
      action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
      options.desc = "代码操作";
    }
  ];
  programs.nixvim.extraConfigLua = ''
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function()
        local _border = "rounded"
        vim.diagnostic.config({
          virtual_text = true,
          signs = {
            active = true,
            text = {
              [vim.diagnostic.severity.ERROR] = "",
              [vim.diagnostic.severity.WARN] = "",
              [vim.diagnostic.severity.INFO] = "",
              [vim.diagnostic.severity.HINT] = "💡",
            },
          },
          update_in_insert = true,
          underline = true,
          severity_sort = true,
          float = {
            border = _border,
          },
        })
      end,
    })
  '';
}
