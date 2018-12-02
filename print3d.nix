{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    perl
    perlPackages.ExtUtilsCppGuess
    #cura
    cura_stable
    #curaLulzbot
    #slic3r
    slic3r-prusa3d
    printrun
  ];
}
