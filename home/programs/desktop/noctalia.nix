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
  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    customPalettes.stylix.dark = with config.lib.stylix.colors.withHashtag; {
      mPrimary = base0E;
      mOnPrimary = base00;
      mSecondary = base08;
      mOnSecondary = base00;
      mTertiary = base0C;
      mOnTertiary = base00;
      mError = base08;
      mOnError = base00;
      mSurface = base00;
      mOnSurface = base05;
      mHover = base0D;
      mOnHover = base00;
      mSurfaceVariant = base01;
      mOnSurfaceVariant = base04;
      mOutline = base03;
      mShadow = base00;

      terminal = {
        foreground = base05;
        background = base00;
        cursor = base05;
        cursorText = base00;
        selectionFg = base05;
        selectionBg = base02;
        normal = {
          black = base00;
          red = base08;
          green = base0B;
          yellow = base0A;
          blue = base0D;
          magenta = base0E;
          cyan = base0C;
          white = base05;
        };
        bright = {
          black = base03;
          red = base08;
          green = base0B;
          yellow = base0A;
          blue = base0D;
          magenta = base0E;
          cyan = base0C;
          white = base07;
        };
      };
    };

    settings = {
      shell = {
        avatar_path = "/home/${user}/.face";
        font_family = config.stylix.fonts.sansSerif.name;
        panel = {
          transparency_mode = "glass";
        };
      };

      bar.main = {
        capsule = true;
        background_opacity = 0.85;
        margin_h = 6;
        margin_v = 6;
        start = [ "workspaces" ];
        center = [
          "cpu"
          "temp"
          "ram"
        ];
        end = [
          "tray"
          "volume"
          "battery"
          "clock"
          "control-center"
        ];
      };

      widget = {
        workspaces = {
          display = "none";
          hide_when_empty = false;
        };
        clock = {
          format = "{:%H:%M %a, %b %d}";
          vertical_format = "{:%H:%M}";
          font_family = config.stylix.fonts.monospace.name;
        };
        battery = {
          hide_when_full = false;
          hide_when_plugged = false;
        };
      };

      battery.warning_threshold = 30;

      nightlight = {
        enabled = true;
        force = false;
        temperature_night = 5000;
      };

      location.address = "北京";

      wallpaper.enabled = true;

      dock.enabled = false;

      theme = {
        source = "builtin";
        templates.enable_builtin_templates = false;
      };

      weather.enabled = true;

      idle = {
        pre_action_fade_seconds = 10;
        behavior = {
          lock = {
            enabled = true;
            timeout = 560;
            action = "lock";
          };
          screen-off = {
            enabled = true;
            timeout = 500;
            action = "screen_off";
          };
        };
      };
    };
  };

  systemd.user.services.noctalia-blur-sync =
    let
      noctaliaBin = "${noctaliaPackage}/bin/noctalia";
      blurSync = pkgs.writeShellApplication {
        name = "noctalia-blur-sync";
        runtimeInputs = with pkgs; [
          imagemagick
          awww
          niri
        ];
        bashOptions = [ ];
        extraShellCheckFlags = [ ];
        text = ''
          USER_HOME="''${HOME}"
          BLUR_DIR="$USER_HOME/Pictures/.cache/blurred"
          NAMESPACE="backdrop"
          POLL_INTERVAL=5
          AWWW_CHECK_EVERY=6

          mkdir -p "$BLUR_DIR"

          log() { echo "[blur-sync] $(date +%H:%M:%S) $*"; }

          get_monitor() {
              niri msg outputs 2>/dev/null | sed -n '1s/.*(\([^)]*\)).*/\1/p'
          }

          get_current_wallpaper() {
              ${noctaliaBin} msg wallpaper-get 2>/dev/null
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

          sync_blur() {
              local wp
              wp="$(get_current_wallpaper)"
              [ -z "$wp" ] && return
              [ ! -f "$wp" ] && return

              local name blur
              name="$(basename "$wp" | sed 's/\.[^.]*$//')"
              blur="$BLUR_DIR/''${name}-blurred.jpg"

              if [ ! -f "$blur" ]; then
                  magick "$wp" -blur 0x30 "$blur" 2>/dev/null && log "generated: $blur"
              fi

              local mon
              mon="$(get_monitor)"
              if [ -n "$mon" ]; then
                  awww img --namespace "$NAMESPACE" -o "$mon" "$blur" 2>/dev/null && log "backdrop: $blur"
              fi
          }

          log "starting..."
          sleep 3
          init_awww
          sync_blur

          last_wp=""
          tick=0

          while true; do
              sleep "$POLL_INTERVAL"

              cur_wp="$(get_current_wallpaper)"
              if [ "$cur_wp" != "$last_wp" ] && [ -n "$cur_wp" ]; then
                  last_wp="$cur_wp"
                  log "wallpaper changed, syncing..."
                  sync_blur
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
        After = [ "graphical-session.target" "noctalia.service" ];
        PartOf = [ "graphical-session.target" ];
        X-Restart-Triggers = [ noctaliaPackage ];
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
