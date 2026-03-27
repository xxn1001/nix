# Largely copied from https://github.com/flickowoa/dotfiles/tree/aurora
{ config, ... }:
with config.lib.stylix.colors;
let
  moduleConfiguration =
    # jsonc
    ''
      // Modules configuration
      "niri/workspaces": {
        "format": "{icon}",
          "format-icons": {
          "default": ""
        },
      },
      "niri/window": {
        "format": "{}",
        "separate-outputs": true,
        "icon": true,
        "icon-size": 18
      },
      "memory": {
        "interval": 30,
        "format": "<span foreground='#${base0E}'>  </span>   {used:0.1f}G/{total:0.1f}G",
        "on-click": "kitty --class=htop,htop -e htop"
      },
      "backlight": {
        "device": "intel_backlight",
        "on-scroll-up": "light -A 1",
        "on-scroll-down": "light -U 1",
        "format": "<span size='13000' foreground='#${base0D}'>{icon} </span>  {percent}%",
        "format-icons": [
          "",
          ""
        ]
      },
      "tray": {
        "icon-size": 16,
        "spacing": 10
      },
      "clock": {
        "format": "<span foreground='#${base0E}'>  </span>  {:%a %d %H:%M}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "on-click": "kitty --class=clock,clock --title=clock -o remember_window_size=no -o initial_window_width=600 -o initial_window_height=200 -e tty-clock -s -c -C 5"
      },
      "battery": {
        "states": {
          "warning": 30,
          "critical": 15,
        },
        "format": "<span size='13000' foreground='#${base0E}'>{icon}  </span>{capacity}%",
        "format-warning": "<span size='13000' foreground='#${base0E}'>{icon}  </span>{capacity}%",
        "format-critical": "<span size='13000' foreground='#${base08}'>{icon}  </span>{capacity}%",
        "format-charging": "<span size='13000' foreground='#${base0E}'>  </span>{capacity}%",
        "format-plugged": "<span size='13000' foreground='#${base0E}'>  </span>{capacity}%",
        "format-alt": "<span size='13000' foreground='#${base0E}'>{icon} </span>{time}",
        "format-full": "<span size='13000' foreground='#${base0E}'>  </span>{capacity}%",
        "format-icons": [
          "",
          "",
          "",
          "",
          ""
        ],
        "tooltip-format": "{time}",
        "interval": 5
      },
      "network": {
        "format-wifi": "<span size='13000' foreground='#${base06}'>󰖩  </span>{essid}",
        "format-ethernet": "<span size='13000' foreground='#${base06}'>󰤭</span> Disconnected",
        "format-linked": "{ifname} (No IP) 󱚵",
        "format-disconnected": "<span size='13000' foreground='#${base06}'> </span>Disconnected",
        "tooltip-format-wifi": "Signal Strenght: {signalStrength}%",
        "on-click": "kitty --class nmtui,nmtui --title=nmtui -o remember_window_size=no -o initial_window_width=400 -o initial_window_height=400 -e nmtui"
      },
      "pulseaudio": {
        "on-click": "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
        "on-scroll-up": "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01+",
        "on-scroll-down": "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01-",
        "format": "<span size='13000' foreground='#${base0A}'>{icon}  </span>{volume}%",
        "format-muted": "<span size='13000' foreground='#${base0A}'>  </span>Muted",
        "format-icons": {
          "headphone": "󱡏",
          "hands-free": "",
          "headset": "󱡏",
          "phone": "",
          "portable": "",
          "car": "",
          "default": [
            "󰕿",
            "󰖀",
            "󰕾",
            "󰕾"
          ]
        }
      },
      "group/meters": {
        "orientation": "inherit",
        "drawer": {
          "transition-duration": 500,
          "transition-left-to-right": false,
        },
        "modules": [
          "battery",
          "memory",
          "network",
          "pulseaudio",
          "backlight"
        ]
      }
    '';
  trayBackgroundColor = if config.stylix.polarity == "dark" then "@base00" else "@base05";
  colors = {
    inherit (withHashtag)
      base00 base01 base04 base05 base06 base07 base08 base0A base0B base0D base0E base0F;
  };
in
{
  programs.waybar = {
    enable = true; # 已取消注释，确保软件包被安装
    systemd = {
      enable = true;
      target = config.wayland.systemd.target;
    };
  };

  home.file = {
    ".config/waybar/config.jsonc".text =
      let
        otherMonitorsConfig =
          map (
            name:
            ''
              {
                "position": "top",
                "layer": "top",
                "output": "${name}",
                "modules-left": [ "niri/workspaces", "niri/window" ],
                "modules-right": [ "tray", "group/meters" ],
                ${moduleConfiguration}
              }
            '') config.lib.monitors.otherMonitorsNames
          |> builtins.concatStringsSep "\n";
      in
      ''
        [
          ${otherMonitorsConfig}
          {
            "position": "top",
            "layer": "top",
            "output": "${config.lib.monitors.mainMonitorName}",
            "modules-left": [ "niri/workspaces", "tray", "niri/window" ],
            "modules-center": [ "clock", "memory" ],
            "modules-right": [ "network", "pulseaudio", "backlight", "battery" ],
            ${moduleConfiguration}
          }
        ]
      '';

    ".config/waybar/colors.css".text =
      (builtins.mapAttrs (name: value: "@define-color ${name} ${value};") colors)
      |> builtins.attrValues
      |> builtins.concatStringsSep "\n";

    ".config/waybar/tray.css".text =
      ''
        #tray {
          background: shade(alpha(${trayBackgroundColor}, 0.9), 1);
        }
      '';

    ".config/waybar/style.css".text =
      ''
        @import "animation.css";
        @import "colors.css";
        @import "tray.css";

        * {
          font-size: 14px;
          font-family: "Hug Me Tight", "Xiaolai SC";
          min-height: 0;
        }

        window#waybar {
          background: transparent;
        }

        tooltip {
          background: @base01;
          border-radius: 5px;
          border-width: 2px;
          border-style: solid;
          border-color: @base07;
        }

        #network, #clock, #battery, #pulseaudio, #workspaces, #backlight, #memory, #tray, #window {
          padding: 4px 10px;
          background: shade(alpha(@base00, 0.9), 1);
          text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.377);
          color: @base05;
          margin-top: 10px;
          margin-bottom: 5px;
          margin-left: 5px;
          margin-right: 5px;
          box-shadow: 1px 2px 2px #101010;
          border-radius: 10px;
        }

        #workspaces {
          margin-left: 15px;
          font-size: 0px;
          padding: 6px 3px;
          border-radius: 20px;
        }

        #workspaces button {
          font-size: 0px;
          background-color: @base07;
          padding: 0px 1px;
          margin: 0px 4px;
          border-radius: 20px;
          /* 保留切换时的物理动感 */
          transition: all 0.25s cubic-bezier(0.55, -0.68, 0.48, 1.682);
        }

        #workspaces button.active {
          font-size: 1px;
          background-color: @base0E;
          border-radius: 20px;
          min-width: 30px;
          /* 移除 background-size 以减少 CPU 负担 */
        }

        #workspaces button.empty {
          font-size: 1px;
          background-color: @base04;
        }

        #window {
          color: @base00;
          background: radial-gradient(circle, @base05 0%, @base07 100%);
          /* 移除 animation 和 background-size，保留静态渐变 */
          transition: all 0.3s cubic-bezier(0.55, -0.68, 0.48, 1.682);
        }

        window#waybar.empty #window {
          background: none;
          background-color: transparent;
          box-shadow: none;
        }

        #battery {
          margin-right: 15px;
          background: @base0F;
          background: linear-gradient(
            118deg,
            @base0B 5%, @base0F 5%, @base0F 20%, @base0B 20%,
            @base0B 40%, @base0F 40%, @base0F 60%, @base0B 60%,
            @base0B 80%, @base0F 80%, @base0F 95%, @base0B 95%
          );
          /* 移除 animation 和 background-size */
          color: @base01;
        }

        #battery.charging, #battery.plugged {
          background: linear-gradient(
            118deg,
            @base0E 5%, @base0D 5%, @base0D 20%, @base0E 20%,
            @base0E 40%, @base0D 40%, @base0D 60%, @base0E 60%,
            @base0E 80%, @base0D 80%, @base0D 95%, @base0E 95%
          );
        }

        #battery.full {
          background: linear-gradient(
            118deg,
            @base0E 5%, @base0D 5%, @base0D 20%, @base0E 20%,
            @base0E 40%, @base0D 40%, @base0D 60%, @base0E 60%,
            @base0E 80%, @base0D 80%, @base0D 95%, @base0E 95%
          );
        }

        #tray > .passive { -gtk-icon-effect: dim; }
        #tray > .needs-attention { -gtk-icon-effect: highlight; }
      '';

    # 清空 animation.css 内容以彻底杜绝 keyframes 定义
    ".config/waybar/animation.css".text = ""; 
  };
}
