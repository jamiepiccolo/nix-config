{ config, lib, pkgs, ... }:

{
  imports = [
    ./hyprland-environment.nix
  ];

  #test later systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    settings = {
      monitor = [
        "DP-3,1920x1080,-1920x0,1"
        "HDMI-A-1,1920x1080@240,0x0,1"
      ];
      exec-once = [
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "waybar"
        "/usr/lib/polkit-kde-authentication-agent-1"
        "easyeffects --gapplication-service"
        "sleep 1 && keepassxc"
        "[workspace 3 silent] sleep 1 && telegram-desktop"
      ];
      env = [
        "XCURSOR_SIZE,24"
      ];
      input = {
        kb_layout = "us";
        follow_mouse = 1;

        touchpad = {
          natural_scroll = "no";
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        accel_profile = "flat";
      };
      general = {
        gaps_in = 2;
        gaps_out = 6;
        border_size = 1;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };
      misc = {
        disable_hyprland_logo = true;
        # disable_hypr_chan = true;
        vrr = 1;
        focus_on_activate = true;
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 2;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
        # col = {
        #   shadow = "rgba(1a1a1aee)";
        # };
      };

      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = "yes"; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true;
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = "off";
      };
      windowrulev2 = [
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "size 1280 720,class:(.*)(gamescope-wrapped)"
        "center,class:^(.gamescope-wrapped)$"
        "float,class:class^(.gamescope-wrapped)$"
      ];
      "$mainMod" = "SUPER";
      binde = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        # Example volume button that will activate even while an input inhibitor is active
        ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bind = [
        "$mainMod, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mainMod, RETURN, exec, foot"
        "$mainMod SHIFT, Q, killactive,"
        "$mainMod, F, fullscreen"
        "$mainMod, M, exit, "
        "$mainMod, E, exec, dolphin"
        "$mainMod, V, togglefloating,"
        # "$mainMod, R, exec, wofi --show drun
        # "$mainMod, R, exec, tofi-drun --font /usr/share/fonts/TTF/MesloLGS-NF-Bold.ttf --num-results=8 --hint-font false --drun-launch=true
        "$mainMod, R, exec, tofi-drun --font /run/current-system/sw/share/X11/fonts/HackNerdFontMono-Bold.ttf --num-results=8 --hint-font false --drun-launch=true --width 100% --height 100% --border-width 0 --outline-width 0 --padding-left 35% --padding-top 25% --result-spacing 25"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, J, togglesplit," # dwindle



        #bind =,XF86AudioMicMute,exec,pamixer --default-source -t
        #bind =,XF86MonBrightnessDown,exec,light -U 20
        #bind =,XF86MonBrightnessUp,exec,light -A 20
        ",XF86AudioMute,exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay,exec,playerctl play-pause"
        ",XF86AudioPause,exec,playerctl play-pause"
        ",XF86AudioNext,exec,playerctl next"
        ",XF86AudioPrev,exec,playerctl previous"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"


      ];
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}

