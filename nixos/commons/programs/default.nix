{ pkgs, inputs, ... }:
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
      extraPkgs = pkgs: with pkgs; [
        gamescope
        mangohud_git
      ];
    };
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        desiredgov = "performance";
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
  chaotic.mesa-git.enable = true;

  programs.gamescope.enable = true;
  # programs.gamescope.package = pkgs.gamescope_git;
  programs.starship.enable = true;
  programs.bash.shellAliases = {
    nightmodeon = "hyprctl keyword decoration:screen_shader \"$HOME/.config/hypr/shaders/blue-light-filter.glsl\"";
    nightmodeoff = "hyprctl keyword decoration:screen_shader \"[[EMPTY]]\"";
  };
  xdg = {
    mime = {
      enable = true;
    };
    portal = {
      enable = true;
      extraPortals = [
        pkgs.libsForQt5.xdg-desktop-portal-kde
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
    # libsForQt5.polkit-kde-agent
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
        obs-gstreamer
        obs-vkcapture
        obs-vaapi
        obs-pipewire-audio-capture
      ];
    })
    gst_all_1.gstreamer
    gst_all_1.gst-vaapi
    gst_all_1.gst-plugins-base
    gitFull
    mpv
    rnix-lsp
    home-manager
    foot
    kitty
    inputs.prince.packages.${pkgs.system}.default
    mangohud_git
    waybar
    vscodium
    neovim
    slurp
    grim
    xdg-utils
    glxinfo
    seatd
    xorg.xrandr
    audacity
    readline
    vscode-extensions.jnoortheen.nix-ide
    vscode-extensions.usernamehw.errorlens
    zig
    ripgrep
    unzip
    wget
    go
    nodejs_20
    fd
    flutter
    dart
    cmake
    fluffychat
    nheko
    gnome.gnome-keyring
    libsecret
    llvmPackages_16.llvm
    gcc
    cargo

    # Neovim Lsp Servers
    rust-analyzer
    rustc
    rustfmt
    clippy
    gopls
    nil
    nixpkgs-fmt
    lua-language-server
    nodePackages.svelte-language-server
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    hyprpaper
    logseq
    cloudflare-warp
  ];

  programs.hyprland = {
    enable = true;
  };
}
