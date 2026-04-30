{ pkgs, config, lib, user, ... }:
with config.lib.stylix.colors.withHashtag;
let
  extraConfig =
    # kdl
    ''
      blur {
          passes 3
          offset 3
          noise 0.02
          saturation 1.5
      }
      window-rule {
          background-effect {
              xray true
              blur true
          }
      }
      window-rule {
          match is-floating=true
          background-effect {
              xray false
              blur true
          }
      }
      layer-rule {
          match namespace="launcher"
          background-effect {
              xray false
              blur true
          }
      }

      recent-windows {
          open-delay-ms 150

          highlight {
              active-color "${base0E}aa"
              urgent-color "${base08}aa"
              padding 30
              corner-radius 20
          }

          previews {
              max-height 480
              max-scale 0.5
          }
      }
    '';
  finalNiriConfig =
    builtins.replaceStrings
      [
        "output \"${config.lib.monitors.mainMonitorName}\" {"
      ]
      [
        ''
          output "${config.lib.monitors.mainMonitorName}" {
              hot-corners {
                  top-left
              }
        ''
      ]
      config.programs.niri.finalConfig
    + "\n"
    + extraConfig;
in
{
  home.file.".config/niri/config-override.kdl".text = finalNiriConfig;
}
