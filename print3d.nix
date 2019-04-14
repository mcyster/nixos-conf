{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    parted
    usbutils
    setserial
    screen
    #python27Full
    #python27
    #python27.pkgs.monotonic
    #pythonPackages.monotonic
    #python3
    #perl
    #perlPackages.ExtUtilsCppGuess
    cura
    #cura_stable
    #curaLulzbot
    #slic3r
    #slic3r-prusa3d
    #printrun
    #mono
    #octoprint
  ];

}
