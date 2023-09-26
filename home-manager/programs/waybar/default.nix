{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
                     * {
          border: none;
          border-radius: 0;
          /* `otf-font-awesome` is required to be installed for icons */
          /* font-family: Liberation Mono; */
          /* font-family: MesloLGS NF; */
          font-family: Hack Nerd Font;
          font-size: 11px;
          /*min-height: 20px;*/
      }

      window#waybar {
          background: transparent;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      #workspaces {
          margin-right: 8px;
          border-radius: 10px;
          transition: none;
          background: #383c4a;
      }

      #workspaces button {
          transition: none;
          color: #7c818c;
          background: transparent;
          padding: 1px 2px;
          font-size: 18px;
      }

      #workspaces button.persistent {
          color: #7c818c;
          font-size: 12px;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
          transition: none;
          box-shadow: inherit;
          text-shadow: inherit;
          border-radius: inherit;
          color: #383c4a;
          background: #7c818c;
      }

      #workspaces button.active {
          color: white;
      }

      #language {
          padding-left: 16px;
          padding-right: 8px;
          border-radius: 10px 0px 0px 10px;
          transition: none;
          color: #ffffff;
          background: #383c4a;
      }

      #keyboard-state {
          margin-right: 8px;
          padding-right: 16px;
          border-radius: 0px 10px 10px 0px;
          transition: none;
          color: #ffffff;
          background: #383c4a;
      }

      #custom-pacman {
          padding-left: 16px;
          padding-right: 8px;
          border-radius: 10px 0px 0px 10px;
          transition: none;
          color: #ffffff;
          background: #383c4a;
      }

      #custom-mail {
          margin-right: 8px;
          padding-right: 16px;
          border-radius: 0px 10px 10px 0px;
          transition: none;
          color: #ffffff;
          background: #383c4a;
      }

      #mode {
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: #383c4a;
      }

      #clock {
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px 10px 10px 10px;
          transition: none;
          color: #ffffff;
          background: #383c4a;
      }

      #custom-weather {
          padding-right: 16px;
          border-radius: 0px 10px 10px 0px;
          transition: none;
          color: #ffffff;
          background: #383c4a;
      }

      #pulseaudio {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: #383c4a;
      }

      #pulseaudio.muted {
          background-color: #90b1b1;
          color: #2a5c45;
      }

      #custom-mem {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: #383c4a;
      }

      #network {
        margin-left: 8px;
        padding-right: 8px;
        padding-left: 16px;
        border-top-left-radius: 10px;
        border-bottom-left-radius: 10px;
        /* border-radius: 10px; */
        transition: none;
        color: #fff;
        background: #383c4a;
      }

      #temperature {
        padding-left: 8px;
          /* margin-right: 8px; */
          padding-right: 16px;
        border-top-right-radius: 10px;
        border-bottom-right-radius: 10px;
          /* border-radius: 10px; */
          transition: none;
          color: #ffffff;
          background: #383c4a;
        margin-right: 8px;
      }

      #temperature.critical {
          background-color: #eb4d4b;
      }

      #backlight {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: #383c4a;
      }

      #battery {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: #383c4a;
      }

      #battery.charging {
          color: #ffffff;
          background-color: #26A65B;
      }

      #battery.warning:not(.charging) {
          background-color: #ffbe61;
          color: black;
      }

      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #tray {
          padding-left: 10px;
          padding-right: 10px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: #383c4a;
      }

      #tray * {
        margin-left: 4px;
        margin-right: 4px;
        padding: 0;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }
      	       '';
    settings = [{
      "clock" = {
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format" = "{:%a, %d %b, %I:%M %p %Z}";
        "locale" = "en_GB.UTF-8";
        "calendar" = {
          "format" = {
            "today" = "<span color='#33ccff'><b><u>{}</u></b></span>";
          };
        };
      };
      "layer" = "top";
      "margin" = "8 8 0 8";
      "modules-left" = [ "hyprland/workspaces" ];
      "modules-center" = [ "clock" ];
      "modules-right" = [ "network" "temperature" "pulseaudio" "tray" ];
      "network" = {
        "format-wifi" = "{essid} {frequency} {icon}";
        "format-disconnected" = "Disconnected {icon}";
        "tooltip-format-wifi" = "{ipaddr} {gwaddr} {signalStrength}";
        "format-icons" = [ "󰤮" "󰤟" "󰤢" "󰤥" "󰤨" ];
      };
      "temperature" = {
        "critical-threshold" = 80;
        "format" = "{temperatureC}°C {icon}";
        "format-icons" = [ "" "" "" "" "" ];
        "tooltip" = false;
      };
      "pulseaudio" = {
        "reverse-scrolling" = 1;
        "format" = "{volume}% {icon} {format_source}";
        "format-bluetooth" = "{volume}% {icon} {format_source}";
        "format-bluetooth-muted" = " {icon} {format_source}";
        "format-muted" = "婢 {format_source}";
        "format-source" = "{volume}% ";
        "format-source-muted" = "";
        "format-icons" = {
          "headphone" = "";
          "hands-free" = "";
          "headset" = "";
          "phone" = "";
          "portable" = "";
          "car" = "";
          "default" = [ "" "" "" ];
        };
        "on-click" = "pavucontrol";
        "min-length" = 13;
      };
      "tray" = {
        "icon-size" = 16;
        "spacing" = 0;
      };
    }];
  };
}
