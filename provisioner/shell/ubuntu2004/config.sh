#!/bin/bash
printf "Config stage.\n"

# Config TimeZone
timedatectl set-timezone Europe/Paris

# Config LANG
printf "LC_ALL=en_US.UTF-8\n" >> /etc/environment
printf "LANG=en_US.UTF-8\n" >> /etc/environment
printf "LANGUAGE=en_US.UTF-8\n" >> /etc/environment
printf "PYTHONIOENCODING=utf8\n" >> /etc/environment

# Network
cat <<-EOF > /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: true
      dhcp6: false
      optional: true
      nameservers:
        addresses: [9.9.9.9, 149.112.112.112]
EOF

# Apply the network plan configuration.
netplan generate

sed -i -e "s/DNS=.*/DNS=9.9.9.9 149.112.112.112/g" /etc/systemd/resolved.conf
