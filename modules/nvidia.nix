{ pkgs, config, lib, ... }:

{
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # required
    modesetting.enable = true;

    # experimental, can cause sleep/suspend to fail
    powerManagement.enable = false;
    
    # turn GPU off when not in use, only work on modern GPUs
    powerManagement.finegrained = false;

    # open source kernel module (noveau)
    open = false;

    # enable Nvidia settings menu
    nvidiaSettings = true;

    # select the update branch of the drivers
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      sync.enable = true;

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = [ "on-the-go" ];
      hardware.nvidia.prime = {
        offload.enable = lib.mkForce true;
	offload.enableOffloadCmd = lib.mkForce true;
	sync.enable = lib.mkForce false;
      };
    };
  };
}
