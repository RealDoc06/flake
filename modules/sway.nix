{ config, pkgs, inputs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      wf-recorder
      mako
      grim
      alacritty
      wofi
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland
    '';
  };

  programs.waybar.enable = true;

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "xcb";
    QT_QUICK_BACKEND = "software";
    LIBGL_ALWAYS_SOFTWARE = "1";
    MOZ_ENABLE_WAYLAND = "0";
    ELECTRON_OZONE_PLATFORM_HINT = "x11";
    ELECTRON_DISABLE_GPU = "true";
  };


}
