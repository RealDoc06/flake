{ config, pkgs, inputs, ... }:
{
  
  environment.gnome.excludePackages = with pkgs; [
    pkgs.baobab 
    cheese 
    eog 
    epiphany
    gedit
    simple-scan
    totem
    yelp
    evince
    geary
    seahorse
    gnome-calculator
    gnome-characters 
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-terminal
    pkgs.gnome-connections
    pkgs.gnome-text-editor
    pkgs.gnome-tour
    pkgs.gnome-photos
  ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.compact-top-bar
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.vitals
    gnomeExtensions.spotify-controls
  ];
  
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}
