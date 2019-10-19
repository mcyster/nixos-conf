{ config, pkgs, ... }:

{
  imports =
    [
      ./extole-vpn.nix
    ];

  services.dnsmasq.extraConfig = ''
    server=/vpn.intole.net/8.8.8.8
    server=/.ec2.internal/10.1.0.2
    server=/.intole.net/10.1.0.2
    conf-dir=/etc/dnsmasq.d
  '';

  networking.firewall.enable = true;
  # these are ports necessary for nfs communication between lo and nixos
  networking.firewall.allowedTCPPorts = [ 2049 20048 111 ];
  networking.firewall.allowedUDPPorts = [ 20048 111 ];

  virtualisation.virtualbox.host.enable = true;
  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    tcpdump
    lsof
    vim
    git
    jq
    zip
    unzip
    google-chrome
    firefox
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.mcyster = {
     isNormalUser = true;
     uid = 2042;
     group = "mcyster";
     extraGroups = [ "wheel" "audio" "video" "systemd-journal" "systemd-network" "dialout" ];
  };

  users.extraGroups.mcyster = {
    gid = 2042;
  };

  services.nfs.server.enable = false;
  services.nfs.server.exports = ''
/home/mcyster/extole 10.11.14.16(rw)
  '';

  # Deprecated - use ~/extolerc.conf per user
  environment.variables.E_GITHUB_TOKEN = pkgs.lib.mkOverride 0 "YOUR_GITHUB_TOKEN";
  environment.variables.E_UID = pkgs.lib.mkOverride 0 "YOUR_UID";
  environment.variables.E_GID = pkgs.lib.mkOverride 0 "YOUR_GID";
  environment.variables.E_VM_NFS_OPTIONS = pkgs.lib.mkOverride 0 "vers=3,rw";
  environment.variables.E_VM_MEMORY = pkgs.lib.mkOverride 0 "NUMBER_OF_MEGABYTES_HERE";
  environment.variables.E_VM_CPUS = pkgs.lib.mkOverride 0 "NUMBER_OF_CORES";
}
