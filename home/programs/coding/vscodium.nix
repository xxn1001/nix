{ pkgs, ... }:
let
  jonathanharty.gruvbox-material-icon-theme =
    pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = {
        name = "gruvbox-material-icon-theme";
        publisher = "JonathanHarty";
        version = "1.1.5";
        hash = "sha256-86UWUuWKT6adx4hw4OJw3cSZxWZKLH4uLTO+Ssg75gY=";
      };
    };
in
{
  programs.vscodium = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ## C/C++
        ms-vscode.cpptools
        llvm-vs-code-extensions.vscode-clangd

        ## Go
        golang.go

        ## Nix
        jnoortheen.nix-ide
        arrterian.nix-env-selector

        ## Others
        ziglang.vscode-zig
        yzhang.markdown-all-in-one

        ## Color scheme
        jdinhlife.gruvbox
        jonathanharty.gruvbox-material-icon-theme
      ];

      userSettings = {
        ## Telemetry & updates
        "update.mode" = "none";
        "extensions.autoUpdate" = false;
        "telemetry.telemetryLevel" = "off";

        ## Appearance
        "window.titleBarStyle" = "custom";
        "window.menuBarVisibility" = "toggle";
        "workbench.colorTheme" = "Gruvbox Light Soft";
        "workbench.iconTheme" = "gruvbox-material-icon-theme";
        "material-icon-theme.folders.theme" = "classic";
        "vsicons.dontShowNewVersionMessage" = true;
        "workbench.startupEditor" = "welcomePage";
        "workbench.sideBar.location" = "left";
        "workbench.activityBar.location" = "top";
        "workbench.statusBar.visible" = true;
        "workbench.editor.showTabs" = "multiple";
        "workbench.editor.limit.enabled" = true;
        "workbench.editor.limit.value" = 10;
        "workbench.editor.limit.perEditorGroup" = true;
        "workbench.layoutControl.type" = "menu";
        "workbench.layoutControl.enabled" = true;
        "breadcrumbs.enabled" = true;
        "explorer.openEditors.visible" = 9;
        "explorer.confirmDragAndDrop" = true;

        ## Font
        "editor.fontFamily" = "'Maple Mono', 'SymbolsNerdFont', 'monospace', monospace";
        "terminal.integrated.fontFamily" = "'Maple Mono', 'SymbolsNerdFont'";
        "editor.fontSize" = 18;
        "editor.fontLigatures" = true;

        ## Editor
        "editor.rulers" = [ 80 100 ];
        "editor.minimap.enabled" = true;
        "editor.renderWhitespace" = "all";
        "editor.lineNumbers" = "relative";
        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.smoothScrolling" = true;
        "editor.mouseWheelZoom" = true;
        "editor.guides.bracketPairs" = true;
        "editor.guides.indentation" = true;
        "editor.stickyScroll.enabled" = true;
        "editor.renderControlCharacters" = true;
        "editor.inlayHints.enabled" = "on";
        "editor.linkedEditing" = true;

        ## Scrollbar
        "editor.scrollbar.verticalScrollbarSize" = 12;
        "editor.scrollbar.horizontalScrollbarSize" = 12;
        "editor.scrollbar.vertical" = "auto";
        "editor.scrollbar.horizontal" = "auto";

        ## Formatting
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
        "editor.formatOnPaste" = true;

        ## Files
        "files.autoSave" = "onWindowChange";
        "files.insertFinalNewline" = true;
        "files.trimTrailingWhitespace" = true;

        ## Terminal
        "terminal.integrated.cursorBlinking" = true;
        "terminal.integrated.smoothScrolling" = true;

        ## C/C++ (clangd)
        "clangd.arguments" = [ "--clang-tidy" "--inlay-hints=true" ];

        ## C/C++ (cpptools / GDB debugging)
        "C_Cpp.default.cppStandard" = "c++20";
        "C_Cpp.default.cStandard" = "c17";
        "C_Cpp.intelliSenseEngine" = "disabled";

        ## Go
        "go.toolsManagement.autoUpdate" = true;
        "go.useLanguageServer" = true;
        "go.delveConfig" = {
          "dlvLoadConfig" = {
            "followPointers" = true;
            "maxVariableRecurse" = 3;
            "maxStringLen" = 400;
            "maxArrayValues" = 400;
            "maxStructFields" = -1;
          };
          "apiVersion" = 2;
          "showGlobalVariables" = true;
        };

        ## Zig
        "zig.path" = "zig";
        "zig.zls.path" = "zls";
        "zig.zls.enabled" = "on";
        "zig.zls.warnStyle" = true;
        "zig.buildOnSaveProvider" = "zls";

        ## Nix
        "nix.serverPath" = "nixd";
        "nix.enableLanguageServer" = true;
      };

      keybindings = [
        {
          key = "ctrl+q";
          command = "editor.action.commentLine";
          when = "editorTextFocus && !editorReadonly";
        }
        {
          key = "ctrl+s";
          command = "workbench.action.files.saveFiles";
        }
        {
          key = "tab";
          command = "selectNextSuggestion";
          when = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
        }
        {
          key = "shift+tab";
          command = "selectPrevSuggestion";
          when = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
        }
      ];
    };
  };

  stylix.targets.vscode.enable = true;

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "codium.desktop";
    "text/x-csrc" = "codium.desktop";
    "application/x-shellscript" = "codium.desktop";
    "application/x-x509-ca-cert" = "codium.desktop";
  };
}
