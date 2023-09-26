{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./programs
  ];

  nix.package = pkgs.nix;
  
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
    enable = true;
    userName = "NotAgentBilly";
    userEmail = "82730686+NotAgentBilly@users.noreply.github.com";
  };

  xdg.desktopEntries = {
    steam-gamescope = {
      name = "steam-gamescope";
      terminal = false;
      exec = "gamescope -W 2560 -H 1440 -w 1920 -h 1080 -r 240 --adaptive-sync --immediate-flips -e -F fsr --fsr-sharpness 5 -- steam -tenfoot -steamos";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
