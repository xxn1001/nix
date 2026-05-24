{
  config,
  lib,
  user,
  inputs,
  pkgs,
  ...
}:
let
  noctaliaPackage = inputs.noctalia-shell.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  programs.noctalia-shell = {
    enable = true;
    colors = with config.lib.stylix.colors.withHashtag; {
      mError = base08;
      mHover = base0E;
      mOnError = base00;
      mOnHover = base00;
      mOnPrimary = base00;
      mOnSecondary = base01;
      mOnSurface = base05;
      mOnSurfaceVariant = base07;
      mOnTeritiary = base00;
      mOutline = base02;
      mPrimary = base0B;
      mSecondary = base0A;
      mShadow = "#000000";
      mSurface = base01;
      mSurfaceVariant = base01;
      mTeritiary = base0C;
    };
    settings = {
      setupCompleted = true;
      bar = {
        density = "comfortable";
        floating = true;
        showCapsule = true;
        outerCorners = true;
        marginVertical = 6;
        marginHorizontal = 6;
        widgets = {
          center = [
            {
              id = "SystemMonitor";
              showCpuTemp = true;
              showCpuUsage = true;
              showDiskUsage = false;
              showMemoryAsPercent = false;
              showMemoryUsage = true;
              showNetworkoStats = false;
              usePrimaryColor = true;
            }
          ];
          left = [
            {
              id = "Workspace";
              labelMode = "none";
              hideUnoccupied = false;
            }
          ];
          right = [
            {
              id = "Tray";
              drawerEnabled = false;
              colorizeIcons = false;
              blacklist = [ ];
            }
            {
              id = "Volume";
              displayMode = "onhover";
            }
            {
              id = "Battery";
              displayMode = "alwaysShow";
              warningThreshold = 30;
            }
            {
              id = "Clock";
              customFont = "Monofur Nerd Font Mono";
              formatHorizontal = "HH:mm ddd, MMM dd";
              formatVertical = "HH mm - dd MM";
              useCustomFont = true;
              usePrimaryColor = true;
            }
            {
              id = "ControlCenter";
              useDistroLogo = false;
            }
          ];
        };
      };
      controlCenter.cards = [
        {
          enabled = true;
          id = "profile-card";
        }
        {
          enabled = true;
          id = "shortcuts-card";
        }
        {
          enabled = true;
          id = "audio-card";
        }
        {
          enabled = true;
          id = "brightness-card";
        }
        {
          enabled = true;
          id = "weather-card";
        }
        {
          enabled = true;
          id = "media-sysmon-card";
        }
      ];
      idle = {
        enabled = true;
        screenOffTimeout = 500;
        lockTimeout = 560;
        suspendTimeout = 1800;
        fadeDuration = 10;
      };
      colorSchemes = {
        generateTemplatesForPredefined = false;
        useWallpaperColors = false;
      };
      general = {
        avatarImage = "/home/${user}/.face";
        forceBlackScreenCorners = false;
        showScreenCorners = false;
      };
      location = {
        name = "北京";
      };
      ui = {
        fontDefault = config.stylix.fonts.sansSerif.name;
        fontFixed = config.stylix.fonts.monospace.name;
        panelBackgroundOpacity = 0.85;
      };
      dock.enabled = false;
      wallpaper.enabled = true;
      nightLight = {
        enabled = true;
        forced = false;
        nightTemp = "5000";
      };
      desktopWidgets = {
        editMode = false;
        enabled = true;
        monitorWidgets = [
          {
            name = config.lib.monitors.mainMonitorName;
            widgets = [
              {
                id = "Clock";
                showBackground = true;
                x = 80;
                y = 100;
              }
              {
                id = "Weather";
                showBackground = true;
                x = 80;
                y = 300;
              }
            ];
          }
        ];
      };
    };
  };

  systemd.user.services.noctalia-shell =
    let
      noctaliaConfig = "/home/${user}/.config/noctalia/settings.json";
    in
    {
      Unit = {
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
        StartLimitIntervalSec = 60;
        StartLimitBurst = 3;
        X-Restart-Triggers = [
          noctaliaPackage
          noctaliaConfig
        ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
        ExecStart = "${noctaliaPackage}/bin/noctalia-shell";
        Restart = "on-failure";
        RestartSec = 3;
        TimeoutStartSec = 10;
        TimeoutStopSec = 5;
        Environment = [
          "NOCTALIA_SETTINGS_FALLBACK=${noctaliaConfig}"
        ];
      };
    };

  systemd.user.services.noctalia-blur-sync =
    let
      blurSync = pkgs.writeShellApplication {
        name = "noctalia-blur-sync";
        runtimeInputs = with pkgs; [
          imagemagick
          awww
          jq
          niri
        ];
        bashOptions = [ ];
        extraShellCheckFlags = [ ];
        text = ''
          USER_HOME="''${HOME}"
          WALLPAPERS_JSON="$USER_HOME/.cache/noctalia/wallpapers.json"
          BLUR_DIR="$USER_HOME/Pictures/.cache/blurred"
          NAMESPACE="backdrop"
          POLL_INTERVAL=5
          AWWW_CHECK_EVERY=6

          mkdir -p "$BLUR_DIR"

          log() { echo "[blur-sync] $(date +%H:%M:%S) $*"; }

          get_monitor() {
              niri msg outputs 2>/dev/null | sed -n '1s/.*(\([^)]*\)).*/\1/p'
          }

          get_current_wallpapers() {
              if [ -f "$WALLPAPERS_JSON" ]; then
                  jq -r '.wallpapers // {} | to_entries[].value | .dark, .light' "$WALLPAPERS_JSON" 2>/dev/null | sort -u
              fi
          }

          init_awww() {
              if ! pgrep -f "awww-daemon.*$NAMESPACE" >/dev/null 2>&1; then
                  awww kill 2>/dev/null || true
                  sleep 0.5
                  awww-daemon --namespace "$NAMESPACE" &
                  sleep 1
                  awww restore --namespace "$NAMESPACE" 2>/dev/null || true
                  log "awww backdrop daemon started"
              fi
          }

          sync_once() {
              get_current_wallpapers | while IFS= read -r wp; do
                  [ -z "$wp" ] && continue
                  [ ! -f "$wp" ] && continue

                  name="$(basename "$wp" | sed 's/\.[^.]*$//')"
                  blur="$BLUR_DIR/''${name}-blurred.jpg"

                  if [ ! -f "$blur" ]; then
                      magick "$wp" -blur 0x30 "$blur" 2>/dev/null && log "generated: $blur"
                  fi

                  mon="$(get_monitor)"
                  if [ -n "$mon" ]; then
                      awww img --namespace "$NAMESPACE" -o "$mon" "$blur" 2>/dev/null && log "backdrop: $blur"
                  fi
              done
          }

          log "starting..."
          sleep 3
          init_awww
          sync_once

          last_mtime="$(stat -c %Y "$WALLPAPERS_JSON" 2>/dev/null || echo 0)"
          tick=0

          while true; do
              sleep "$POLL_INTERVAL"

              if [ -f "$WALLPAPERS_JSON" ]; then
                  cur_mtime="$(stat -c %Y "$WALLPAPERS_JSON" 2>/dev/null || echo 0)"
                  if [ "$cur_mtime" != "$last_mtime" ]; then
                      last_mtime="$cur_mtime"
                      log "wallpapers.json changed, syncing..."
                      sync_once
                  fi
              fi

              tick=$((tick + 1))
              if [ "$tick" -ge "$AWWW_CHECK_EVERY" ]; then
                  tick=0
                  init_awww
              fi
          done
        '';
      };
    in
    {
      Unit = {
        After = [ "graphical-session.target" "noctalia-shell.service" ];
        PartOf = [ "graphical-session.target" ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
        ExecStart = "${blurSync}/bin/noctalia-blur-sync";
        Restart = "on-failure";
        RestartSec = 10;
      };
    };

  home.packages = with pkgs; [
    noctaliaPackage
    imagemagick
    awww
  ];
}
