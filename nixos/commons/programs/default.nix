{ pkgs, ...}:
{
  imports = [
    ./firefox
  ];

  programs.mtr.enable = true;
  programs.dconf.enable = true;

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        MANGOHUD = true;
        OBS_VKCAPTURE = true;
      };
      extraLibraries = p: with p; [
        gamescope
        mangohud
      ];
    };
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        desiredgov = "performance";
        defaultgov = "performance";
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        amd_performance_level = "high";
        gpu_device = 0;
      };
    };
  };



  chaotic.steam.extraCompatPackages = with pkgs; [
    proton-ge-custom
  ];

  programs.gamescope.enable = true;

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        libsForQt5.xdg-desktop-portal-kde
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    conky
    keepassxc
    telegram-desktop
    tofi
    libsForQt5.dolphin
    libsForQt5.polkit-kde-agent
    gnome.nautilus
    udisks
    xorg.xeyes
    wl-clipboard
    gnome.gnome-system-monitor
    wayvnc
    glib
    easyeffects
    thunderbird
    playerctl
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi
        obs-vkcapture
      ];
    })
    gst_all_1.gstreamer
    gst_all_1.gst-vaapi
    mpv
    rustup
    rnix-lsp
    home-manager
  ];
}
