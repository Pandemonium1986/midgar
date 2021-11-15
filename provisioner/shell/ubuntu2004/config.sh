#!/bin/bash
printf "Config stage.\n"

# Config TimeZone
timedatectl set-timezone Europe/Paris

# Config LANG
printf "LC_ALL=en_US.UTF-8\n" >> /etc/environment
printf "LANG=en_US.UTF-8\n" >> /etc/environment
printf "LANGUAGE=en_US.UTF-8\n" >> /etc/environment
printf "PYTHONIOENCODING=utf8\n" >> /etc/environment
