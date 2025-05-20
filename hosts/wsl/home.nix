{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    #./home-manager-modules/hyprland.nix
  ];

  home.username = "doc";
  home.homeDirectory = "/home/doc";
  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  home.stateVersion = "24.11";  

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    (inputs.nvf.lib.neovimConfiguration {
      pkgs = pkgs;
      modules = [ ../../nvf-configuration.nix ];
    }).neovim
    pkgs.lshw
    pkgs.tree
    pkgs.nmap
    pkgs.python3
    pkgs.screen
    pkgs.sshfs
    pkgs.fastfetch
    pkgs.jq
    pkgs.unzip
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
  # catppuccin.gtk = {
  #   enable = true;
  #   flavor = "frappe";
  #   accent = "sky";
  #   size = "standard";
  #   tweaks = [ "normal" ];
  # };
  
  programs.home-manager.enable = true;
  programs.zed-editor.enable = true;
  programs.btop.enable = true;
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
}
