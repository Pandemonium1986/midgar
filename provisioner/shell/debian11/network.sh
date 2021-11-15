#!/bin/bash -eux

# To allow for autmated installs, we disable interactive configuration steps.
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

# Ensure the loopback, and default network interface are automatically enabled and then dhcp'ed.
printf "allow-hotplug eth0\n" >> /etc/network/interfaces
printf "auto lo\n" >> /etc/network/interfaces
printf "iface lo inet loopback\n" >> /etc/network/interfaces
printf "iface eth0 inet dhcp\n" >> /etc/network/interfaces
printf "dns-nameserver 4.2.2.1\n" >> /etc/network/interfaces
printf "dns-nameserver 4.2.2.2\n" >> /etc/network/interfaces
printf "dns-nameserver 208.67.220.220\n" >> /etc/network/interfaces

# Adding a delay so dhclient will work properly.
printf "pre-up sleep 2\n" >> /etc/network/interfaces

# Ensure a nameserver is being used that won't return an IP for non-existent domain names.
printf "nameserver 4.2.2.1\nnameserver 4.2.2.2\nnameserver 208.67.220.220\n" > /etc/resolv.conf
