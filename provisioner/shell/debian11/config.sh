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
sed -i -e 's/4\.2\.2\.1/9\.9\.9\.9/g' /etc/network/interfaces
sed -i -e 's/4\.2\.2\.2/149\.112\.112\.112/g' /etc/network/interfaces
sed -i -e '/dns-nameserver 208\.67\.220\.220/d' /etc/network/interfaces
sed -i -e 's/4\.2\.2\.1/9\.9\.9\.9/g' /etc/resolv.conf
sed -i -e 's/4\.2\.2\.2/149\.112\.112\.112/g' /etc/resolv.conf
sed -i -e '/nameserver 208\.67\.220\.220/d' /etc/resolv.conf
