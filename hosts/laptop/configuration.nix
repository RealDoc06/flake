# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ../modules/nvidia.nix
      inputs.home-manager.nixosModules.default
      inputs.catppuccin.nixosModules.catppuccin
    ];

  documentation.enable = false;

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    default = "saved";
    useOSProber = true;
    device = "nodev";
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
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

  services.goxlr-utility.enable = true;
  services.goxlr-utility.autoStart.xdg = true;

  # Per far andare Solaar
  hardware.logitech.wireless.enable = true;

  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "alt-intl";
  };

  # Configure console keymap
  console.keyMap = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  swapDevices = [
    {
      device = "/swapfile";
    }
  ];

  programs.zsh.enable = true;
  programs.light.enable = true;
  # programs.hyprland.enable = true;
  # programs.hyprland.package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
  # programs.hyprland.portalPackage = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".xdg-desktop-portal-hyprland;

  users.users.doc = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Sebastian Pugliese";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
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
      # import ./home.nix;
    };
  };

  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
  ];
  system.stateVersion = "24.11"; # Did you read the comment?

}
