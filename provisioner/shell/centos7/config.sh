#!/bin/bash
printf "Config stage.\n"

# Config TimeZone
printf "ZONE=\"Europe/Paris\"\n" > /etc/sysconfig/clock
restorecon -Rv /etc/localtime
timedatectl set-timezone Europe/Paris

# Config LANG
printf "LC_ALL=en_US.UTF-8" >> /etc/environment
printf "LANG=en_US.UTF-8" >> /etc/environment
printf "LANGUAGE=en_US.UTF-8" >> /etc/environment
printf "PYTHONIOENCODING=utf8" >> /etc/environment

# Bootstrap ansible (dirty fix)
yum install --assumeyes python-setuptools
