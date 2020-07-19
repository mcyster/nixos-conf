{ config, pkgs, ... }:

{
  services.minecraft-server = {
    enable = true;
    eula = true;
  };

  environment.systemPackages = with pkgs; [
    minecraft
    minecraft-server
  ];
}

