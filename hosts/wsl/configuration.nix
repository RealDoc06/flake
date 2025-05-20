{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.catppuccin.nixosModules.catppuccin
  ];

  documentation.enable = false;

  # Bootloader — non serve in WSL, rimosso

  networking.hostName = "wsl";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Rome";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Audio non serve in WSL, PipeWire e PulseAudio disabilitati
  services.pulseaudio.enable = false;
  services.pipewire.enable = false;

  # X11, stampa e GoXLR non rilevanti per WSL — disabilitati/rimossi

  console.keyMap = "us";

  swapDevices = [ ];

  programs.zsh.enable = true;
  programs.light.enable = true;

  users.users.doc = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Sebastian Pugliese";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users = {
      "doc" = {
        imports = [
          ./home.nix
          inputs.catppuccin.homeModules.catppuccin
        ];
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
  ];

  system.stateVersion = "24.11";
}
