{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ./hyprland-environment.nix
  ];

  #test later systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemdIntegration = true;
    extraConfig = ''
      monitor = DP-3,1920x1080,-1920x0,1 #,bitdepth,10
      monitor = HDMI-A-1,1920x1080@240,0x0,1 #,bitdepth,10
      exec-once = xrandr --output \"HDMI-A-1\" --primary
      exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = waybar
      exec-once = /usr/lib/polkit-kde-authentication-agent-1
      exec-once = easyeffects --gapplication-service
      exec-once = sleep 1 && keepassxc
      exec-once = [workspace 3 silent] sleep 1 && telegram-desktop
      exec-once = hyprpaper 
      env = XCURSOR_SIZE,24
      env = WLR_RENDERER,vulkan

      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = QT_QPA_PLATFORMTHEME,qt5ct

      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_DESKTOP,Hyprland
      env = XDG_SESSION_TYPE,wayland

      env = MOZ_ENABLE_WAYLAND,1
      env = NIXOS_OZONE_WL,1
      env = RADV_PERFTEST,gpl,nggc,sam

      env = SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS,0
      env = MESA_GL_VERSION_OVERRIDE,4.6
      input {
        kb_layout = us
        follow_mouse = 1

        touchpad {
          natural_scroll = no
        };

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        accel_profile = flat
      }
      general {
        allow_tearing = false
        gaps_in = 2
        gaps_out = 6
        border_size = 1
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)
        layout = dwindle
      }
      misc {
        disable_hyprland_logo = true
        # disable_hypr_chan = true
        vrr = 1
        #focus_on_activate = true
      }
      decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 2

        blur {
          enabled = false
          size = 3
          passes = 1
        }

        drop_shadow = yes
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
        # col = {
        #   shadow = rgba(1a1a1aee)
        # };
      }

      animations {
        enabled = yes
        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
      }

      dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
      }

      master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true
      }

      gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = off
      }
      windowrulev2 = opacity 0.98,class:^(.*)$
      windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
      windowrulev2 = noanim,class:^(xwaylandvideobridge)$
      windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
      windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$
      windowrulev2 = size 1280 720,class:(.*)(gamescope-wrapped)
      windowrulev2 = center,class:^(.gamescope-wrapped)$
      windowrulev2 = float,class:^(.gamescope-wrapped)$
      windowrulev2 = noanim,class:^(cs2|steam_app_271590)$
      windowrulev2 = tile,class:^(cs2|steam_app_271590)$
      #windowrulev2 = size 1280 720,class:^(cs2|steam|steam_app_271590)$
      windowrulev2 = monitor HDMI-A-1,class:^(cs2|steam|steam_app_271590)$
      windowrulev2 = noborder,class:^(cs2|steam_app_271590)$

      $mainMod = SUPER;
      binde = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
      # Example volume button that will activate even while an input inhibitor is active
      binde = ,XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-
      bind = $mainMod, S, exec, slurp | grim -g - - | wl-copy
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, RETURN, exec, foot
      bind = $mainMod SHIFT, Q, killactive,
      bind = $mainMod, F, fullscreen
      bind = $mainMod, M, exit, 
      bind = $mainMod, E, exec, dolphin
      bind = $mainMod, V, togglefloating,
      # "$mainMod, R, exec, wofi --show drun
      # "$mainMod, R, exec, tofi-drun --font /usr/share/fonts/TTF/MesloLGS-NF-Bold.ttf --num-results=8 --hint-font false --drun-launch=true
      bind = $mainMod, R, exec, tofi-drun --font /run/current-system/sw/share/X11/fonts/HackNerdFontMono-Bold.ttf --num-results=8 --hint-font false --drun-launch=true --width 100% --height 100% --border-width 0 --outline-width 0 --padding-left 35% --padding-top 25% --result-spacing 25
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle



      #bind =,XF86AudioMicMute,exec,pamixer --default-source -t
      #bind =,XF86MonBrightnessDown,exec,light -U 20
      #bind =,XF86MonBrightnessUp,exec,light -A 20
      bind = ,XF86AudioMute,exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind = ,XF86AudioPlay,exec,playerctl play-pause
      bind = ,XF86AudioPause,exec,playerctl play-pause
      bind = ,XF86AudioNext,exec,playerctl next
      bind = ,XF86AudioPrev,exec,playerctl previous

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';
  };
}

