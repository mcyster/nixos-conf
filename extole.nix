{ config, pkgs, ... }:

{
  imports =
    [
      ./vpn-extole.nix
    ];

  services.dnsmasq.enable = true;

  # Extole US DNS Servers
  services.dnsmasq.servers = [ "68.94.156.1" "68.94.157.1" ];

  services.dnsmasq.extraConfig = ''
    server=/vpn.intole.net/8.8.8.8
    server=/.ec2.internal/10.1.0.2
    server=/.intole.net/10.1.0.2
    conf-dir=/etc/dnsmasq.d
  '';

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
/home/mcyster/extole 10.11.14.16(rw)
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


  # Deprecated use ~/extolerc.conf
  #environment.variables.E_GITHUB_TOKEN = pkgs.lib.mkOverride 0 "YOUR_GITHUB_TOKEN";
  #environment.variables.E_UID = pkgs.lib.mkOverride 0 "YOUR_UID";
  #environment.variables.E_GID = pkgs.lib.mkOverride 0 "YOUR_GID";
  #environment.variables.E_VM_NFS_OPTIONS = pkgs.lib.mkOverride 0 "vers=3,rw";
  #environment.variables.E_VM_MEMORY = pkgs.lib.mkOverride 0 "NUMBER_OF_MEGABYTES_HERE";
  #environment.variables.E_VM_CPUS = pkgs.lib.mkOverride 0 "NUMBER_OF_CORES";
}
