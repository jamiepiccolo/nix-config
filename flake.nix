{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    # Choatic Pkgs (https://www.nyx.chaotic.cx/#lists)
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    hyprland.url = "github:hyprwm/Hyprland";
    xdph.url = "github:hyprwm/xdg-desktop-portal-hyprland";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs =
    { self
    , nixpkgs
    , chaotic
    , home-manager
    , hyprland
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
    in
    {
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        agent69420 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          # > Our main nixos configuration file <
          system = "x86_64-linux";
          modules = [
            ./nixos/configuration.nix
            chaotic.nixosModules.default
            # home-manager.nixosModules.home-manager
            # hyprland.homeManagerModules.default
            # {
              # home-manager.useGlobalPkgs = true;
              # home-manager.useUserPackages = true;
              # home-manager.users.agent69 = import ./home-manager/home.nix;
            # }
          ];
        };
      };

      # Available through 'home-manager --flake .#your-username@your-hostname'
      # homeConfigurations = {
      #   "agent69@agent69420" = home-manager.lib.homeManagerConfiguration {
      #     pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
      #     extraSpecialArgs = { inherit inputs outputs; };
      #     modules = [
      #       ./home-manager/home.nix
      #       chaotic.homeManagerModules.default
      #       hyprland.homeManagerModules.default
      #       {wayland.windowManager.hyprland.enable = true;}
      #     ];
      #   };
      # };
    };
}
