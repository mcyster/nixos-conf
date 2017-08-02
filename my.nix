{ config, pkgs, ... }:

{
  i18n = {
     consoleKeyMap = "us";
  };

  time.timeZone = "America/Los_Angeles";

  environment.systemPackages = with pkgs; [
    tcpdump
    acpi
    dmidecode
    lshw
    lsof
    vim
    #vim_configurable
    git
    jq
    zip
    unzip
    chromium
    eclipses.eclipse-sdk
  ];

  users.extraUsers.wal = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
  };

  environment.variables.EDITOR = pkgs.lib.mkOverride 0 "vim";
  environment.variables.BROWSER = pkgs.lib.mkOverride 0 "chromium";
}
