#!/bin/bash
printf "Config stage.\n"

# Config TimeZone
printf "ZONE=\"Europe/Paris\"\n" > /etc/sysconfig/clock
restorecon -Rv /etc/localtime
timedatectl set-timezone Europe/Paris

# sshd
