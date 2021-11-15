#!/bin/bash
printf "Config stage.\n"

# Config TimeZone
timedatectl set-timezone Europe/Paris

# Config LANG
printf "LC_ALL=en_US.UTF-8" >> /etc/environment
printf "LANG=en_US.UTF-8" >> /etc/environment
printf "LANGUAGE=en_US.UTF-8" >> /etc/environment
printf "PYTHONIOENCODING=utf8" >> /etc/environment

# Network
sed -i -e 's/^dns-nameserver.*//' /etc/network/interfaces
sed -i -e 's/^nameserver.*//' /etc/resolv.conf
printf "nameserver 127.0.0.53" >> /etc/resolv.conf
