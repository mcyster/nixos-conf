{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./my.nix
      ./extole.nix
      # ./extole-sf-printer.nix
      #./print3d.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "roo";
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.netdata.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";

  # services.xserver.xkbOptions = "eurosign:e";

  # services.xserver.videoDrivers = [ "nouveau" ];
  # services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  # services.xserver.displayManager.gdm.wayland = false;

  system.autoUpgrade.enable = true;
  nixpkgs.config.allowUnfree = true;
}

