{ config, pkgs, inputs, ... }:
let
  screenshotScript = pkgs.writeShellScriptBin "current_monitor_screenshot" ''
    monitor=$(hyprctl activeworkspace -j | jq -r .monitor)
    grim -o "$monitor" - | wl-copy
  '';
in
{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
    
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

  };

  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    screenshotScript
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
