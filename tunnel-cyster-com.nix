#
# include this file in /etc/nixos/configuration.nix
# then
#   # add autossh user to remote system
#   sudo -u autossh ssh-keygen -b 4096 -f .ssh/id_rsa -C autossh@$(hostname)
#   # if you can login as autossh (bad idea)
#   sudo -u autossh cat .ssh/id_rsa.pub | ssh autossh@cyster.com "cat >> .ssh/authorized_keys"
#   # test with
#   sudo -u autossh ssh autossh@cyster.com
#   

{ config, libs, pkgs, ...}:
{
  users.extraUsers.autossh = {
    home = "/home/autossh";
  };

  systemd.services.tunnel-cyster-com = {
    description = "Tunnel over ssh to cyster.com";
    after = [ "network.target" ];
    serviceConfig = {
      User = "autossh";
      ExecStart = "${pkgs.openssh}/bin/ssh -NTC -o ServerAliveInterval=60 -o ExitOnForwardFailure=yes -o StrictHostKeyChecking=no -i %h/.ssh/servername-home-key -R 1124:localhost:22 autossh@cyster.com";
      RestartSec = "15";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };
  systemd.services.tunnel-cyster-com.enable = true;
}

