{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    inputs.chaotic.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    ./programs
  ];

  # nix.package = pkgs.nix;

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "agent69";
    homeDirectory = "/home/agent69";
  };

  # Add stuff for your user as you see fit:
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  programs.home-manager.enable = true;
  programs.git = {
    package = pkgs.gitFull;
    enable = true;
    userName = "NotAgentBilly";
    userEmail = "82730686+NotAgentBilly@users.noreply.github.com";
  };
  programs.readline = {
    enable = true;
    extraConfig = ''
      set completion-ignore-case on
    '';
  };

  xdg =
    {
      enable = true;
      desktopEntries = {
        steam-gamescope = {
          name = "steam-gamescope";
          terminal = false;
          exec = "gamescope -W 2560 -H 1440 -w 1920 -h 1080 -r 240 --adaptive-sync --immediate-flips -e -F fsr --fsr-sharpness 5 -- steam -tenfoot -steamos";
        };
      };
    };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.pointerCursor =
    let
      getFrom = url: hash: name: {
        gtk.enable = true;
        x11.enable = true;
        name = name;
        size = 48;
        package =
          pkgs.runCommand "moveUp" { } ''
            mkdir -p $out/share/icons
            ln -s ${pkgs.fetchzip {
              url = url;
              hash = hash;
            }} $out/share/icons/${name}
          '';
      };
    in
    getFrom
      "https://github.com/ful1e5/fuchsia-cursor/releases/download/v2.0.0/Fuchsia-Pop.tar.gz"
      "sha256-BvVE9qupMjw7JRqFUj1J0a4ys6kc9fOLBPx2bGaapTk="
      "Fuchsia-Pop";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
