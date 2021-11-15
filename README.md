# Midgar

[![Vagrant Cloud](https://img.shields.io/badge/vagrant-midgar-lightgrey.svg)](https://app.vagrantup.com/pandemonium/boxes/midgar)
![](https://img.shields.io/github/release/Pandemonium1986/midgar.svg)
![](https://img.shields.io/github/repo-size/Pandemonium1986/midgar.svg)
![](https://img.shields.io/github/release-date/Pandemonium1986/midgar.svg)
![](https://img.shields.io/github/license/Pandemonium1986/midgar.svg)

Debian/Mint environment provided with my basic tools.  

## Getting Started

This project start/build a virtualbox vm from my [pandemonium/debian10](https://app.vagrantup.com/pandemonium/boxes/debian10) or [pandemonium/mint1903](https://app.vagrantup.com/pandemonium/boxes/mint1903).  
Both boxes are provisioned with ansible. Allowing to deploy all the tools I use for development.

### Prerequisites

-   [Vagrant](https://www.vagrantup.com/downloads.html) - To build and manage the box.
-   [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - The only provider available.

You can read official documentation for installation instruction and read my cheatsheet.  

-   [Vagrant cheatsheet](https://github.com/Pandemonium1986/cheatsheet/blob/master/VirtualBox.md).  
-   [VirtualBox cheatsheet](https://github.com/Pandemonium1986/cheatsheet/blob/master/Vagrant.md).  

### Installing

Simply initialize and up the box.  
Note midgar box is only available for debian environment. If you want to used the Linux mint environment please refer to "Building" section.

```sh
vagrant init pandemonium/midgar-deb
vagrant up
```

If you want to access to the vm after 'up' use

```sh
vagrant ssh
```

## Building

If you want to build the box, you need to clone the git repository and be sure to have ansible installed.

```sh
git clone https://github.com/Pandemonium1986/midgar.git ~/git/Pandemonium1986/midgar
cd ~/git/Pandemonium1986/midgar
vagrant up
```

Or if you want to choose between midgar-mnt and midgar-deb  

```sh
git clone https://github.com/Pandemonium1986/midgar.git ~/git/Pandemonium1986/midgar
cd ~/git/Pandemonium1986/midgar
vagrant up midgar[-deb|-mnt]
```

## Provisioning

If you wish to provision the box at startup

```sh
vagrant up midgar-mnt|-deb --provision
```

If you want to provision the box after startup

```sh
vagrant provision midgar-mnt|-deb
```

If you want to trigger the playbook mint locally

```sh
ansible-playbook mint.yml -i "localhost," -c local -K
```

## Update

Before upload the box into the vagrant cloud :

```sh
vagrant ssh midgar-deb

# Be sure to add the pandemonium account
sudo visudo
sudo su -

# Update box
apt update && apt dist-upgrade && apt autoremove && apt autoclean
cat /dev/null > .bash_history && history -c # ctrl + d

# Hand over the insecure key
cat /dev/null > ~/.ssh/known_hosts
wget https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub -O ~/.ssh/authorized_keys
cat /dev/null > .bash_history && history -c # ctrl + d
```

## Built With

-   [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) - The provider used.

## Authors

-   **Michael Maffait** - _Initial work_ - [Pandemonium1986](https://github.com/Pandemonium1986)

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details

## Source

-   [Chmod/Chown WSL Improvements](https://blogs.msdn.microsoft.com/commandline/2018/01/12/chmod-chown-wsl-improvements/)
-   [Manage and configure Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/wsl-config#set-wsl-launch-settings)  
-   [Vagrant and Wsl](https://www.vagrantup.com/docs/other/wsl.html)
-   [Wsl cheatsheet](https://github.com/Pandemonium1986/cheatsheet/blob/master/Wsl.md).  

## Note

```sh
# Dotfiles installation
cd ~/git/Pandemonium1986/dotfiles
export PATH="$HOME/.tmuxifier/bin:$HOME/.local/bin/:$PATH"
pip install --upgrade --user ansible ansible-lint beautysh==4.1 gita httpie molecule openstacksdk pip pre-commit youtube-dl
~/.local/bin/ansible-playbook install.yml -c local -i "127.0.0.1," -K

# Minikube quick and dirty starting
# https://github.com/kubernetes/minikube/issues/4350
# https://github.com/kubernetes/kubeadm/issues/193#issuecomment-330060848
sudo systemctl stop docker
sudo iptables --flush
sudo iptables -tnat --flush
sudo systemctl start docker
minikube config set driver docker
minikube start --driver=docker
kubectl get pods -n kube-system

# None driver
# sudo ufw disable
# sudo iptables -L
# free
# nproc
# sudo apt install conntrack
# sudo minikube config set driver none
# CHANGE_MINIKUBE_NONE_USER=true sudo -E minikube start --driver=none

# cts7 fix
sudo yum install libselinux-python3

# Dotfiles install cts7 & cts8
~/.local/bin/ansible-galaxy collection install ansible.posix
~/.local/bin/ansible-playbook install.yml -c local -i "127.0.0.1," -K

```
