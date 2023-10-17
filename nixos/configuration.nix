{ inputs
, outputs
, lib
, config
, pkgs
, modulesPath
, ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-cpu-amd-pstate
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.hyprland.nixosModules.default
    ./commons/locale.nix
    ./commons/network.nix
    ./commons/fonts.nix
    ./commons/services.nix
    ./commons/sound.nix
    ./commons/programs

    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      agent69 = import ../home-manager/home.nix;
    };
  };

  nix =
    let
      # Filter non-flake inputs for the next two functions
      flakes = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      # This will add each flake input as a registry
      # To make nix3 commands consistent with your flake
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakes;

      # This will additionally add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well, awesome!
      nixPath = lib.mapAttrsToList (x: _: "${x}=flake:${x}") flakes;
      package = pkgs.nixFlakes;

      settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Deduplicate and optimize nix store
        auto-optimise-store = true;
      };
    };

  networking.hostName = "agent69420";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  users.users = {
    agent69 = {
      isNormalUser = true;
      description = "agent69";
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [ "wheel" "seat" ];
    };
  };

  services.openssh = {
    enable = false;
    settings = {
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  boot.kernel.sysctl = {
    "kernel.split_lock_mitigate" = 0;
    "net.core.default_qdisc" = "fq_codel";
    "net.ipv4.tcp_ecn" = 1;
    "net.ipv4.tcp_sack" = 1;
    "net.ipv4.tcp_dsack" = 1;
  };

  services.udisks2.enable = true;
  security.polkit.enable = true;
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
