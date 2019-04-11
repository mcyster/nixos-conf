# After install, goto localhost:631 and add printer
{ config, lib, pkgs, ... }:
{
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip pkgs.brlaser ];

  # Enable automatic discovery of the printer from other Linux systems with avahi running.
  services.avahi.enable = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;

  services.printing.browsing = true;
  services.printing.listenAddresses = [ "*:631" ]; # Not 100% sure this is needed and you might want to restrict to the local network
  services.printing.defaultShared = false;

  networking.firewall.allowedUDPPorts = [ 631 ];
  networking.firewall.allowedTCPPorts = [ 631 ];
}
