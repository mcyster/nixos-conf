{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./my.nix
      ./extole.nix
      ./tunnel-cyster-com.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "emu";
  # networking.wireless.enable = true;  
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.netdata.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.desktopManager.gnome3.enable = true;
  #services.xserver.videoDrivers = [ "nvidia" ];
  #services.xserver.videoDrivers = [ "nvidiaBeta" ];
  services.xserver.videoDrivers = [ "nvidiaLegacy340" ];

  system.stateVersion = "17.03";

  nixpkgs.config.allowUnfree = true;
}

