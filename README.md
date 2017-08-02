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

# Host: owl

Hardware
- 1T SSD

# Host: roo

Hardware
- Aging Macbook Pro

Setup

Booted from a minimal Nixos image (17.03) on a USB stick

Wireless network did not come up. `ifconfig` showed the wireless device but no ip.

To get wifi working:
```
systemctl stop wap_supplicant 

wpa_passphrase NAME PASS >>/etc/wpa_supplicant.conf 
wpa_supplicant -B -i wlp2s0b1 -c /etc/wpa_supplicant.conf   # wlp2s0b1 from ifconfig 

cd /nix/store/*dhcp* 
./bin/dhclient wlp2s0b1 

# wait

ip link show
```

Installation:
```
gdisk -l /dev/sda

mkswap -L swap /dev/sda3
mkfs.ext4 -L nixos /dev/sda2
mkfs.vfat /dev/sda1

mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/disk/by-label/swap

mixos-generate-config --root /mnt

cd /mnt/nixos
# curl https://raw.githubusercontent.com/mcyster/nixos-roo/master/configuration.nix >configuration.nix
vi configuration.nix  # edit as needed

nixos-install
```

## Other user configs

<https://github.com/mbbx6spp/mbp-nixos> - on a macbook pro, also has notes on temperature control and brightness

<https://github.com/polynomial/cattle/blob/master/nixos/configuration.nix> - uses trusted binary caches etc

<https://github.com/fooblahblah/nixos/blob/master/configuration.nix> - lots of stuff

<https://github.com/kragniz/configuration.nix/blob/master/configuration.nix> - Gnome3

<https://gist.github.com/domenkozar/9071879> - XFCE

<https://github.com/yamafaktory/nixos-configuration> - specified network details

See <https://nixos.org/nixos/manual/index.html#sec-installation>


