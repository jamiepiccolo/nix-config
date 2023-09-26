{ config, pkgs, ... }:

{
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
      RADV_PERFTEST = "gpl";
    };
  };
}
