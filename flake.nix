{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    hyprland.url = "github:hyprwm/Hyprland";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... }@inputs: {

    packages."x86_64-linux".default =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
	modules = [ ./nvf-configuration.nix ];
      }).neovim;

    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
      	# system = "x86_64-linux";
        specialArgs = { inherit inputs; };
	modules = [
	  ./hosts/laptop/configuration.nix
	  ./modules/nvidia.nix
	  ./modules/hyprland.nix
	  #./modules/noveau.nix
	  #./modules/sway.nix
	  #./modules/gnome.nix
	];
      };
    };
  };
}
