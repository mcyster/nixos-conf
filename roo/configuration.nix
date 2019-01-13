{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./my.nix
      ./extole.nix
#      ./print3d.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "roo";
  # networking.wireless.enable = true;
  # networking.networkmanager.enable = true;

  services.openssh.enable = true;
  services.netdata.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  system.stateVersion = "17.03";
  hardware.pulseaudio.enable = true;

  nixpkgs.config.allowUnfree = true;
}

