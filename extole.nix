{ config, pkgs, ... }:

{
  imports =
    [
      ./vpn/network-extole.nix
    ];

  services.dnsmasq.enable = true;
  services.dnsmasq.servers = [ "68.94.156.1" "68.94.157.1" ];
  services.dnsmasq.extraConfig = ''
    server=/vpn.intole.net/8.8.8.8
    server=/.ec2.internal/10.1.0.2
    server=/.intole.net/10.1.0.2
    conf-dir=/etc/dnsmasq.d
  '';

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
/home/mcyster/extole 10.11.14.16(rw) #,no_subtree_check,all_squash,anonuid=2042,anongid=2042,async)
  '';

  users.extraGroups.mcyster = {
    gid = 2042;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.mcyster = {
     isNormalUser = true;
     uid = 2042;
     group = "mcyster";
     extraGroups = [ "wheel" "audio" "video" "systemd-journal" "systemd-network" "dialout" ];
  };

  security.sudo.wheelNeedsPassword = false;

  virtualisation.virtualbox.host.enable = true;

  networking.firewall.enable = true;
  # these are ports necessary for nfs communication between lo and nixos
  networking.firewall.allowedTCPPorts = [ 2049 20048 111 ];
  networking.firewall.allowedUDPPorts = [ 20048 111 ];
}
