#!/bin/bash
printf "Cleanup stage.\n"

error() {
  if [ $? -ne 0 ]; then
    printf "\n\napt failed...\n\n";
    exit 1
  fi
}

# To allow for autmated installs, we disable interactive configuration steps.
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

# Cleanup unused packages.
apt-get --assume-yes autoremove; error
apt-get --assume-yes autoclean; error

# Clear the random seed.
rm -f /var/lib/systemd/random-seed

# Stop the vm
poweroff
