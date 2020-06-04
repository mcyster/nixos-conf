{ config, pkgs, ... }:

{
  imports =
    [
      ./extole-vpn.nix
    ];

  services.dnsmasq.enable = true;
  services.dnsmasq.extraConfig = ''
    server=/vpn.intole.net/8.8.8.8
    server=/.ec2.internal/10.1.0.2
    server=/.intole.net/10.1.0.2
    conf-dir=/etc/dnsmasq.d
  '';

  networking.firewall.enable = true;

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    git
    tcpdump
    lsof
    vim
    jq
    zip
    unzip
    google-chrome
    firefox
    gnupg
    pinentry
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

}
