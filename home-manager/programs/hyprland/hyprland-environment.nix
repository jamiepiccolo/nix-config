{ config, pkgs, ... }:

{
  systemd.user.sessionVariables = {
    WLR_RENDERER = "vulkan";

    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORMTHEME = "qt5ct";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";

    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    RADV_PERFTEST = "gpl,nggc,sam";
    SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
    MESA_GL_VERSION_OVERRIDE = "4.6";
  };

  pam.sessionVariables = {
    WLR_RENDERER = "vulkan";

    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORMTHEME = "qt5ct";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";

    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    RADV_PERFTEST = "gpl,nggc,sam";
    SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
    MESA_GL_VERSION_OVERRIDE = "4.6";
  };
  home = {
    sessionVariables = {
      #CLUTTER_BACKEND = "wayland";
      WLR_RENDERER = "vulkan";

      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";

      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      RADV_PERFTEST = "gpl,nggc,sam";
      SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
      MESA_GL_VERSION_OVERRIDE = "4.6";
    };
  };

  programs.bash = {
    enable = true;
  };
}
