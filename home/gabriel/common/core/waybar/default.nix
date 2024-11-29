{
  configLib,
  pkgs,
  config,
  ...
}:
let
  wallpapers = builtins.toString (configLib.relativeToRoot "wallpapers");
  cycle_wall = pkgs.callPackage ./scripts/cycle_wall.nix { inherit pkgs wallpapers; };
  screenshot = pkgs.callPackage ./scripts/screenshot.nix { inherit pkgs; };
  select_wallpaper = pkgs.callPackage ../wofi/scripts/select_wallpaper.nix {
    inherit pkgs configLib config;
  };
in
{
  config.programs.waybar = {
    enable = true;

    style = ''
      * {
        border: none;
        font-family: Pixel Code, Fira Code, monospace;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background-color: transparent;
        font-weight: 900;
      }

      window#waybar > * {
        background-color: transparent;
        font-weight: 900;
        padding: 10px 15px;
      }

      #workspaces button{
        box-shadow: rgba(0, 0, 0, 0.116) 2 2 5 2px;
        background-color: #24273a;
        border-radius: 15px;
        margin-right: 10px;
        color: #cad3f5;
      }

      #workspaces button.active{
        padding-right: 20px;
        box-shadow: rgba(0, 0, 0, 0.288) 2 2 5 2px;
        text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
        padding-left: 20px;
        background: linear-gradient(45deg, #8aadf4 0%, #b7bdf8 43%, #7dc4e4 80%, #91d7e3 100%);
        background-size: 300% 300%;
        animation: gradient 10s ease infinite;
        color: #24273a;
      }

      @keyframes gradient {
      	0% {
      		background-position: 0% 50%;
      	}
      	50% {
      		background-position: 100% 50%;
      	}
      	100% {
      		background-position: 0% 50%;
      	}
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #custom-cycle_wall,
      #custom-ss,
      #custom-select_wallpaper,
      #mpd {
        color: #cad3f5;
        padding: 0 10px;
        border-radius: 15px;
        background-color: #24273a;
        box-shadow: rgba(0, 0, 0, 0.116) 2 2 5 2px;
      }

      #window {
        box-shadow: rgba(0, 0, 0, 0.116) 2 2 5 2px;
        border-radius: 15px;
        background: linear-gradient(45deg, #181926 0%, #1e2030 43%, #181926 80%, #181926 100%);
        color: #cad3f5;
        padding: 0 100px;
      }

      #custom-ss, #custom-select_wallpaper {
        background-color: #24273a;
        color: #cad3f5;
        /* padding-left: 20px; */
        /* padding-right: 20px; */
        border-radius: 15px;
      }

      #custom-cycle_wall{
        background: rgb(245,194,231);
        background: linear-gradient(45deg, rgba(245,194,231,1) 0%, rgba(203,166,247,1) 0%, rgba(243,139,168,1) 13%, rgba(235,160,172,1) 26%, rgba(250,179,135,1) 34%, rgba(249,226,175,1) 49%, rgba(166,227,161,1) 65%, rgba(148,226,213,1) 77%, rgba(137,220,235,1) 82%, rgba(116,199,236,1) 88%, rgba(137,180,250,1) 95%);
        color: #fff;
        background-size: 500% 500%;
        animation: gradient 7s linear infinite;
        border-radius: 15px;
      }

      #clock {
        background-color: #24273a;
        color: #cad3f5;
        background-size: 300% 300%;
        text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
        animation: gradient 20s ease infinite;
        padding-top: 5px;
        padding-right: 21px;
        padding-left: 20px
      }

      #battery.charging, #battery.plugged {
        color: #a6da95;
      }

      #battery {
        background-color: #24273a;
        color: #a6da95;
      }

      @keyframes blink {
        to {
          background-color: #f9e2af;
          color:#96804e;
        }
      }

      #battery.critical:not(.charging) {
        background-color:  #f38ba8;
        color: #ed8796;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #cpu {
        background: linear-gradient(52deg, #8aadf4 0%, #b7bdf8 32%, #7dc4e4 72%, #91d7e3 100%);
        background-size: 300% 300%;
        animation: gradient 20s ease infinite;
        text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
        color: 	#24273a;
      }

      #memory {
        background-color: #24273a;
        color: 	#eed49f;
      }

      #disk {
        color: #c6a0f6;
      }

      #backlight {
        color: #8bd5ca;
      }

      #network{
        color: #cad3f5;
      }

      #network.disabled{
        color: #a5adcb;
      }

      #network.disconnected{
        background: rgb(243,139,168);
        background: linear-gradient(45deg, rgba(243,139,168,1) 0%, rgba(250,179,135,1) 100%);
        color: #ed8796;
        padding-top: 3px;
        padding-right: 11px;
      }

      #network.linked, #network.wifi {
        background-color: #24273a;
      }

      #network.ethernet {
        background-color: #24273a;
      }

      #pulseaudio {
        background-color: #24273a;
        color:	#c6a0f6;
      }

      #pulseaudio.muted {
        background-color: #90b1b1;
      }

      #custom-media {
        color: #66cc99;
      }

      #custom-media.custom-spotify {
        background-color: #66cc99;
      }

      #custom-media.custom-vlc {
        background-color: #ffa000;
      }

      #temperature {
        background-color: #24273a;
        color: #cdd6f4;
      }

      #temperature.critical {
        background-color: #f38ba8 ;
        color: #fff;
      }

      #tray {
        color: #2980b9;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eb4d4b;
      }

      #idle_inhibitor {
        background-color: #2d3436;
      }

      #idle_inhibitor.activated {
        background-color: #ecf0f1;
        color: #2d3436;
      }

      #mpd {
        background-color: #66cc99;
        color: #2a5c45;
      }

      #mpd.disconnected {
        background-color: #f53c3c;
      }

      #mpd.stopped {
        background-color: #90b1b1;
      }

      #mpd.paused {
        background-color: #51a37a;
      }

      #language {
        background: #00b093;
        color: #740864;
        padding: 0 5px;
        margin: 0 5px;
        min-width: 16px;
      }

      #keyboard-state {
        background: #97e1ad;
        color: #000000;
        padding: 0 0px;
        margin: 0 5px;
        min-width: 16px;
      }

      #keyboard-state > label {
        padding: 0 5px;
      }

      #keyboard-state > label.locked {
        background: rgba(0, 0, 0, 0.2);
      }

      tooltip {
        background: #24273a;
        font-weight: 900;
        font-size: 18px;
      }

      tooltip label {
        color: #cad3f5;
      }
    '';

    settings = {
      mainBar = {
        height = 50;
        layer = "bottom";
        position = "top";
        spacing = 5;
        margin-bottom = -11;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "tray"
          "pulseaudio"
          "memory"
          "network"
          "battery"
          "custom/select_wallpaper"
          "custom/ss"
          "custom/cycle_wall"
          "custom/expand"
          "cpu"
          "clock"
        ];

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphone = " ";
            hands-free = "";
            headset = "";
            phone = " ";
            portable = " ";
            car = " ";
            default = [
              " "
              " "
            ];
          };
          scroll-step = 1;
          on-click = "hyprctl dispatch exec \"[float] pwvucontrol\"";
          ignored-sinks = [ "Easy Effects Sink" ];
        };
        "custom/ss" = {
          format = "{}  ";
          on-click = screenshot;
        };
        "custom/select_wallpaper" = {
          format = "{} 󰸉 ";
          on-click = select_wallpaper;
        };
        "custom/cycle_wall" = {
          format = "{}";
          on-click = cycle_wall;
        };
        "keyboard-state" = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          "format-icons" = {
            "locked" = "";
            "unlocked" = "";
          };
        };
        "hyprland/window" = {
          format = "{}";
          rewrite = {
            "(.*) — Mozilla Firefox" = "🌎 $1";
            "(.*) — Brave" = "🌎 $1";
            "(.*) - zsh" = "> [$1]";
          };
          separate-outputs = true;
        };
        "wlr/workspaces" = {
          format = "{icon}";
          format-active = " {icon} ";
          on-click = "activate";
        };
        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        mpd = {
          format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ";
          format-disconnected = "Disconnected  ";
          format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
          interval = 10;
          consume-icons = {
            on = " ";
          };
          random-icons = {
            off = "<span color=\"#f53c3c\"></span> ";
            on = " ";
          };
          repeat-icons = {
            on = " ";
          };
          single-icons = {
            on = "1 ";
          };
          state-icons = {
            paused = "";
            playing = "";
          };
          tooltip-format = "MPD (connected)";
          tooltip-format-disconnected = "MPD (disconnected)";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          spacing = 10;
        };
        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          interval = 60;
          format = "{:%I:%M}";
          max-length = 25;
        };
        cpu = {
          interval = 1;
          format = "{icon0} {icon1} {icon2} {icon3}";
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
        };
        memory = {
          format = "{}%  ";
        };
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [ "" ];
        };
        backlight = {
          format = "{percent}% {icon} ";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        battery = {
          bat = "BAT0";
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon} ";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          max-length = 25;
        };
        network = {
          interface = "wlan0";
          format = "{ifname}";
          format-wifi = "{essid} ({signalStrength}%)  ";
          format-ethernet = "{ipaddr}/{cidr} 󰊗";
          format-disconnected = "";
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-wifi = "{essid} ({signalStrength}%)  ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
        };
        "custom/media" = {
          format = "{icon} {}";
          return-type = "json";
          max-length = 40;
          format-icons = {
            spotify = "";
            default = "🎜";
          };
          escape = true;
          exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
        };
      };
    };
  };
}
