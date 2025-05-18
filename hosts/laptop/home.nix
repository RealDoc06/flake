{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    #./home-manager-modules/hyprland.nix
  ];

  home.username = "doc";
  home.homeDirectory = "/home/doc";

  home.stateVersion = "24.11";  

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    (inputs.nvf.lib.neovimConfiguration {
      pkgs = pkgs;
      modules = [ ../../nvf-configuration.nix ];
    }).neovim
    inputs.zen-browser.packages."x86_64-linux".default
    pkgs.lshw
    pkgs.tree
    pkgs.vesktop
    # pkgs.discord
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    pkgs.tailscale
    pkgs.nmap
    pkgs.python3
    pkgs.telegram-desktop
    pkgs.goxlr-utility
    pkgs.prismlauncher
    pkgs.vscode # so i can sync settings across devices
    pkgs.whatsapp-for-linux
    pkgs.pavucontrol
    pkgs.pulseaudio
    pkgs.spotify
    pkgs.solaar
    pkgs.arduino-ide
    pkgs.screen
    pkgs.sshfs
    pkgs.fastfetch
    pkgs.glxinfo
    pkgs.jq
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  home.file = {
  };

  home.file.".zshrc".text = ''
    export EDITOR=nvim
  '';

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
  
  programs.home-manager.enable = true;
  # programs.neovim.enable = true;
  programs.zed-editor.enable = true;
  programs.btop.enable = true;
  programs.spotify-player.enable = true;
  programs.wofi = {
    enable = true;
    # settings and style
  };
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g @catppuccin_flavor 'frappe'

      set -g status-right-length 100
      set -g status-left ""
      
      # Window
      set -g @catppuccin_window_status_style "custom"
      set -g window-status-separator ""
      
      ## Window global/default configuration
      set -g @catppuccin_window_default_text " #{window_name}"
      set -g @catppuccin_window_status "icon"
      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_number_position "left"
      
      set -g @catppuccin_window_left_separator "█"
      set -g @catppuccin_window_middle_separator "█"
      set -g @catppuccin_window_right_separator "█"
      
      ## Window current configuration
      set -g @catppuccin_window_current_text "#{window_name}"
      set -g @catppuccin_window_current_fill "all"
      set -g @catppuccin_window_current_middle_separator "#[reverse] 󰿟 #[noreverse]"
      
      # Status modules config
      set -g @catppuccin_date_time_text "%d-%m %H:%M"
      
      # Run plugin
      run ~/projects/catppuccin-tmux/catppuccin.tmux
      
      # Status
      set -gF  status-right "#{@catppuccin_status_directory}"
      set -agF status-right "#{@catppuccin_status_session}"
      set -agF status-right "#{@catppuccin_status_user}"
      set -agF status-right "#{@catppuccin_status_host}"
      set -agF status-right "#{E:@catppuccin_status_date_time}"
    '';
  };
  programs.cava = {
    enable = true;
    settings = {
      general.framerate = 144;
      input.method = "pulse";
      input.source = "alsa_output.usb-TC-Helicon_GoXLR-00.HiFi__Line2__sink.monitor";
    };
  };
  programs.git = {
    enable = true;
    userName = "doc";
    userEmail = "sesygiallo@gmail.com";
  };
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
#    autosuggestions = {
#      enable = true;
#      async = true;
#    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "sudo"
	"git"
      ];
    };
  };
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.75";
      background_blur = 4;
      cursor_trail = 2;
    };
  };

  catppuccin.hyprland.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    
    package = null;
    portalPackage = null;

    xwayland.enable = true;
    systemd.enable = true;
    # systemd.variables = [ "--all" ];

    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";
      "$browser" = "zen";

      exec-once = [
        "hyprctl dispatch workspace 1"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "alt-intl";
        force_no_accel = true;
      };

      "device[pnp0c50:00-04f3:30aa-touchpad]" = {
        natural_scroll = true;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
      };
      decoration = {
        rounding = 10;
        rounding_power = 2;

        active_opacity = 1.0;
        inactive_opacity = 1.0;
      };

      env = [
        "AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1"
      ];
      monitor = [
        "eDP-1, 1920x1080@144.15, 0x0, 1"
        "HDMI-A-1, 1920x1080@60.00, -1920x0, 1"
      ];
      workspace = [
        "1, monitor:eDP-1"
        "2, monitor:HDMI-A-1"
      ];
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
      ];
      bind = [
        "$mod, M, exit"
        "$mod, T, exec, $browser"
        "$mod, R, exec, $menu"
        "$mod, Space, exec, $menu"
        "$mod, return, exec, $terminal"

        "$mod SHIFT, F, togglefloating"
        "$mod, P, pin"
        "$mod, F, fullscreen"

        # Screenshot
        "$mod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        ", Print, exec, grim - | wl-copy"
        "ALT, Print, exec, current_monitor_screenshot"

        # Focus move (arrow)
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        # Focus move (vim movement)
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"

        # Window move (arrow)
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        # Window move (vim movement)
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"

        "$mod, Q, killactive"
      ] ++ (
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              "$mod ALT_L, code:1${toString i}, focusworkspaceoncurrentmonitor, ${toString ws}"
            ]
          )
        9)
      );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
