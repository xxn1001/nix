{ config, pkgs, user, lib, ... }:
{
  imports = [
    ./animations.nix
    ./waybar.nix
    ./autostart.nix
    ./keybinds.nix
    # ./blur-daemon.nix
    # ./override-config.nix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings =
      with config.lib.stylix.colors.withHashtag;
      let
        shadowConfig = {
          enable = true;
          spread = 0;
          softness = 10;
          color = "#000000dd";
        };
      in
      {
        hotkey-overlay.skip-at-startup = true;
        prefer-no-csd = true;
        
        # input = {
        #   focus-follows-mouse.enable = true;
        #   touchpad.natural-scroll = false;
        #   keyboard.xkb.options = "caps:escape"; 
        # };

        environment = {
          DISPLAY = ":0";
          XIM = "fcitx";
          GTK_IM_MODULE = "fcitx";
          QT_IM_MODULE = "fcitx";
        };

        outputs = builtins.mapAttrs (name: value: {
          inherit (value) scale mode position;
          transform.rotation = value.rotation;
          background-color = base01;
        }) config.monitors;

        # binds = with config.lib.niri.actions; {
        #   "Mod+Return".action = spawn "kitty";
        #   "Mod+P".action = spawn [ "sh" "-c" "$(tofi-run)" ];
        #   "Mod+Shift+C".action = spawn "/home/${user}/scripts/tofi/colorscheme";
        # };

        window-rules =
          let
            matchAppIDs = appIDs: map (appID: { app-id = appID; }) appIDs;
          in
          [
            {
              geometry-corner-radius = {
                bottom-left = 10.0; bottom-right = 10.0;
                top-left = 10.0; top-right = 10.0;
              };
              clip-to-geometry = true;
              draw-border-with-background = false;
            }
            {
              matches = [ { app-id = "yad"; } ];
              open-floating = true;
            }
            # 针对常用工具的比例优化，删除 MATLAB 后列表更干净
            {
              matches = matchAppIDs [
                "firefox" "org.qutebrowser.qutebrowser" "kitty"
                "evince" "zathura" "Zotero" "RStudio"
              ];
              default-column-width = { proportion = 0.95; };
            }
            # 焦点透明度设置
            { matches = [ { is-focused = true; } ]; opacity = 0.92; }
            { matches = [ { is-focused = false; } ]; opacity = 0.75; }
          ];

        layer-rules = [
          {
            matches = [ { namespace = "awww-daemonbackdrop"; } ];
            place-within-backdrop = true;
          }
        ];

        # # 纯单屏工作区配置
        # workspaces = {
        #   "1" = { name = "coding"; };
        #   "2" = { name = "browsing"; };
        #   "3" = { name = "reading"; };
        #   "4" = { name = "music"; };
        # };

        xwayland-satellite = {
          enable = true;
          path = lib.getExe pkgs.xwayland-satellite;
        };

        layout = {
          gaps = 12;
          border = {
            enable = true;
            width = 4;
            active.gradient = {
              from = base07;
              to = base0E;
              angle = 45;
              in' = "oklab";
            };
            inactive.color = base02;
          };
          focus-ring.enable = false;
          shadow = shadowConfig;
        };
      };
  };
}
