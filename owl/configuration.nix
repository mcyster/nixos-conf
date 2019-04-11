# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./my.nix
      ./extole.nix
      ./tunnel-cyster-com.nix
      #./print3d.nix
      ./extole-printer.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "owl";
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;
  #networking.networkmanager.insertNameservers = [ "68.94.156.1" "68.94.157.1" ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.netdata.enable = true;

  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.xkbOptions = "eurosign:e";

  services.xserver.desktopManager.gnome3.enable = true;
  #services.xserver.videoDrivers = [ "nouveau" ];
  services.xserver.videoDrivers = [ "nvidia" ];
  #services.xserver.videoDrivers = [ "nvidiaBeta" ];
  #services.xserver.videoDrivers = [ "nvidiaLegacy340" ];
  services.xserver.displayManager.gdm.wayland=false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.bsmith = {
     isNormalUser = true;
     uid = 1000;
     extraGroups = [ "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;
}

