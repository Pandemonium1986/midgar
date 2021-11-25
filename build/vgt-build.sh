#! /bin/bash
#
# Quick N Dirty way to run and build vagrant midgar boxes

set -euo pipefail
IFS=$'\n\t'

###############
## Functions ##
###############

function _exit() {
  echo -e "\n\e[1;31mCritical error on $(basename $0)\e[0m\n" >&2
  exit 255
}

##########
## Main ##
##########

trap _exit SIGHUP SIGINT SIGQUIT SIGABRT SIGTERM

echo -e "\e[33m--------------------------------------\e[0m\n"
################
## Kenel Code ##
################

## Auth
export VAGRANT_EXPERIMENTAL="dependency_provisioners"
# vagrant cloud auth login --token $VAGRANT_CLOUD_TOKEN
vagrant cloud auth whoami

## Create vagrant box on vagrant cloud
# vagrant cloud box create \
#         pandemonium/midgar-deb \
#         --description "Debian 11 environment base on generic/debian11 provided with my basic tools." \
#         -s "Debian 11 box. See Pandemonium1986/vagrant-midgar on GitHub" \
#         --no-private

## Build
cd ~/git/Pandemonium1986/vagrant-midgar/
vagrant destroy -f
vagrant build

## Package
vagrant package --base midgar-cts7 --output /home/pandemonium/Documents/workspace/vagrant/vgt-cts7 --info ./build/info.json
vagrant package --base midgar-cts --output /home/pandemonium/Documents/workspace/vagrant/vgt-cts --info ./build/info.json
vagrant package --base midgar-ubt --output /home/pandemonium/Documents/workspace/vagrant/vgt-ubt --info ./build/info.json
vagrant package --base midgar-deb --output /home/pandemonium/Documents/workspace/vagrant/vgt-deb --info ./build/info.json
vagrant package --base midgar-mnt --output /home/pandemonium/Documents/workspace/vagrant/vgt-mnt --info ./build/info.json

## Test
vagrant box remove local/midgar-cts7
vagrant box remove local/midgar-cts
vagrant box remove local/midgar-ubt
vagrant box remove local/midgar-deb
vagrant box remove local/midgar-mnt
vagrant box add --name local/midgar-cts7  /home/pandemonium/Documents/workspace/vagrant/vgt-cts7
vagrant box add --name local/midgar-cts  /home/pandemonium/Documents/workspace/vagrant/vgt-cts
vagrant box add --name local/midgar-ubt  /home/pandemonium/Documents/workspace/vagrant/vgt-ubt
vagrant box add --name local/midgar-deb  /home/pandemonium/Documents/workspace/vagrant/vgt-deb
vagrant box add --name local/midgar-mnt  /home/pandemonium/Documents/workspace/vagrant/vgt-mnt

echo -e "\e[33m--------------------------------------\e[0m"

# vagrant cloud publish \
#         pandemonium/midgar-cts7 \
#         1.0.0 \
#         virtualbox \
#         /tmp/vgt-cts7 \
#         --description "A really cool box to download and use" \
#         --short-description "Download me" \
#         --version-description "A cool version" \
#         --no-private \
#         --release
