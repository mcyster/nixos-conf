# Nixos config for `emu`

This is the `/etc/nixos` directory on my workstation `emu`.

Split configuration into 
- configuration.nix, mainly machine specific configuration
- hardware-configuraton.nix, generated during setup, machine specific
- my.nix, a minimal set of tools to get a comfortable environment, use on all my machines
- extole.nix, configuration for work environment, use on machines I use for work
- tunnel-cyster-com, setup a tunnel to a public host I have, use on a few machines

## This repo

Making changes:

* `cd /etc/nixos`
* `./nixos-conf-pull`
* # change configuration files 
* `nixos-rebuild switch`
* check changes, reboot if needed
* `./nixos-conf-push "message"`

Updating:

*  `nixos-rebuild switch --upgrade`

Out of space:

* `nix-collect-garbage -d`

Change channel:

* `nix-channel --list`
* `nix-channel --remove nixos`
* `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`
* `nixos-rebuild switch --upgrade`

## Setup

# Host: emu

Hardware
- ASUS motherboard A6P6
- 256 SSD
- 3 x NVidia Gefore 210 Cards

Booted from a minimal Nixos image (17.03) on a USB stick

Had problems with booting the installed image after using gdisk, so I switched to fdisk.

This script bootstraps this machine: [nixos-bootstrap script](nixos-bootstrap), includes partition sizes

Currently only able to get 1 of the nvidia video cards working

