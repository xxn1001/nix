{ pkgs, lib, ... }:
{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      notify_on_error = true;
      format_on_save = {
        timeout_ms = 600;
        lsp_fallback = true;
      };
      formatters_by_ft = {
        bash = [ "shfmt" "shellcheck" "shellharden" ];
        c = [ "clang_format" ];
        cpp = [ "clang_format" ];
        cmake = [ "cmake_format" ];
        css = [ "prettierd" "prettier" ];
        scss = [ "prettierd" "prettier" ];
        html = [ "prettierd" "prettier" ];
        go = [ "goimports" ];
        javascript = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
        typescript = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
        javascriptreact = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
        typescriptreact = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
        json = [ "prettierd" ];
        lua = [ "stylua" ];
        markdown = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
        nix = [ "alejandra" ];
        python = [ "ruff_fix" "ruff_format" "ruff_organize_imports" ];
        rust = [ "rustfmt" ];
        toml = [ "taplo" ];
        yaml = [ "yamlfmt" ];
        typst = [ "typstyle" ];
      };
      formatters = {
        shfmt.command = lib.getExe pkgs.shfmt;
        shellcheck.command = lib.getExe pkgs.shellcheck;
        shellharden.command = lib.getExe pkgs.shellharden;
        stylua.command = lib.getExe pkgs.stylua;
        yamlfmt.command = lib.getExe pkgs.yamlfmt;
        goimports.command = "${pkgs.gotools}/bin/goimports";
      };
    };
  };
  programs.nixvim.extraPackages = with pkgs; [ cmake-format ];
}
