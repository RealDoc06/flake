{ config, pkgs, lib, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "doc";
  home.homeDirectory = "/home/doc";

  home.stateVersion = "24.11"; # Please read the comment before changing.
  
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
    pkgs.discord
    #    (pkgs.discord.override {
    #      withVencord = true;
    #    })
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

  wayland.windowManager.hyprland = {
    enable = true;
    # package = null;
    # portalPackage = null;
    systemd.variables = [ "--all" ];
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, T, exec, zen"
        "$mod, return, exec, kitty"
        "$mod, Q, killactive"
      ] ++ (
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
        9)
      );
    };
  };
  
  # Sway configuration problematic with nvidia graphic
  wayland.windowManager.sway =
    let
      # Applications and General
      mod = "Mod4";
      term = "kitty";
      browser = "zen";
      app_runner = "wofi --show drun";

      # Movements
      up = "k";
      down = "j";
      right = "l";
      left = "h";
    in {
      enable = true;
      package = null; # package managed my flakes modules
      config = rec {
        modifier = mod;
        terminal = term;
        input = {
          "*" = {
            xkb_layout = "us";
            xkb_variant = "intl";
          };
        };
        output = {
          "eDP-1" = {
            mode = "1920x1080@144.149Hz";
            pos = "0 0";
          };
          "HDMI-A-1" = {
            mode = "1920x1080@60.000Hz";
            pos = "-1920 0";
          };
        };
        keybindings = {
          "${mod}+Return" = "exec ${term}";
          "${mod}+t" = "exec ${browser}";
          "${mod}+r" = "exec ${app_runner}";
          "${mod}+q" = "kill";
          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+e" = "exit";


          # Window management
          "${mod}+${up}" = "focus up";
          "${mod}+${down}" = "focus down";
          "${mod}+${right}" = "focus right";
          "${mod}+${left}" = "focus left";

          "${mod}+Shift+${up}" = "move up";
          "${mod}+Shift+${down}" = "move down";
          "${mod}+Shift+${right}" = "move right";
          "${mod}+Shift+${left}" = "move left";

          # toggle floating
          "${mod}+Shift+f" = "floating toggle";

          # toggle fullscreen
          "${mod}+f" = "fullscreen";

          # Workspaces
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";
        };
        startup = [
          { command = "kitty"; }
        ];
      };
    };
}
