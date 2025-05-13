{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "doc";
  home.homeDirectory = "/home/doc";

  home.stateVersion = "24.11"; # Please read the comment before changing.
  
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    # pkgs.neovim
    # pkgs.kitty
    pkgs.lshw
    # pkgs.git
    pkgs.tree
    pkgs.vesktop
    inputs.zen-browser.packages."x86_64-linux".default
    pkgs.tailscale
    pkgs.nmap
    pkgs.python3
    pkgs.telegram-desktop
    pkgs.goxlr-utility
    pkgs.prismlauncher
    pkgs.vscode # so i can sync settings across devices
    pkgs.whatsapp-for-linux
    pkgs.pavucontrol
    pkgs.spotify
    pkgs.solaar
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # we are catppuccining
  catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "sky";
  };
  catppuccin.gtk = {
    enable = true;
    flavor = "frappe";
    accent = "sky";
    size = "standard";
    tweaks = [ "normal" ];
  };
  
  programs.kitty.enable = true;
  programs.neovim.enable = true;
  programs.zed-editor.enable = true;
  programs.btop.enable = true;
  programs.spotify-player.enable = true;
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "doc";
    userEmail = "sesygiallo@gmail.com";
  };
}
