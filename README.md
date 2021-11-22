# Vagrant Midgar

[![Vagrant Cloud](https://img.shields.io/badge/vagrant-midgar-lightgrey.svg)](https://app.vagrantup.com/pandemonium/boxes/midgar)
![](https://img.shields.io/github/release/Pandemonium1986/vagrant-midgar.svg)
![](https://img.shields.io/github/repo-size/Pandemonium1986/vagrant-midgar.svg)
![](https://img.shields.io/github/release-date/Pandemonium1986/vagrant-midgar.svg)
![](https://img.shields.io/github/license/Pandemonium1986/vagrant-midgar.svg)

CentOS/Debian/Ubuntu/Linux Mint environment provided with my usual tools.

## Getting Started

This project build some `virtualbox` vms base on the [roboxes](https://github.com/lavabit/robox) project as base box.
Vms are provisioned with ansible. Allowing to deploy all the tools I use for development.

The list of supported boxes:

- [generic/centos7](https://app.vagrantup.com/generic/boxes/centos7)
- [generic/centos8](https://app.vagrantup.com/generic/boxes/centos8)
- [generic/debian11](https://app.vagrantup.com/generic/boxes/debian11)
- [generic/ubuntu2004](https://app.vagrantup.com/generic/boxes/ubuntu2004)
- [pandemonium/mint1903](https://app.vagrantup.com/pandemonium/boxes/mint1903)

The list of main tools currently deployed:

- ansible
- ansible-lint
- audacity
- beautysh
- chromium
- clamav
- firefox-esr
- gimp
- git
- gita
- gitlint
- httpie
- jq
- keepassxc
- molecule[docker]
- nmap
- ohmyzsh
- openstacksdk
- pipenv
- pre-commit
- remmina
- tmux
- yamllint
- youtube-dl

### Prerequisites

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) - The provisioner.
- [Vagrant](https://www.vagrantup.com/downloads.html) - To build and manage the box.
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - The only provider available.

### Installing

Simply initialize and run the box.

```sh
vagrant init pandemonium/midgar-deb
vagrant up
```

> Note midgar box is available for this environments:
>
> - centos7 => pandemonium/midgar-cts7
> - centos8 => pandemonium/midgar-cts
> - debian11 => pandemonium/midgar-deb
> - ubuntu2004 => pandemonium/midgar-ubt
> - mint1903 => pandemonium/midgar-mnt

If you want to access to the vm after 'up' use

```sh
vagrant ssh
```

## Building

### Locally

If you want to build one of the boxes, you need to clone the git repository. Make sure you have the prerequisites installed.

```sh
git clone https://github.com/Pandemonium1986/vagrant-midgar.git ~/git/Pandemonium1986/vagrant-midgar
cd ~/git/Pandemonium1986/vagrant-midgar
vagrant up
```

Or if you want to choose from the available boxes:

```sh
git clone https://github.com/Pandemonium1986/vagrant-midgar.git ~/git/Pandemonium1986/vagrant-midgar
cd ~/git/Pandemonium1986/vagrant-midgar
vagrant up midgar[-cts7|-cts|-deb|-ubt|-mnt]
```

### Github Action

`TBD`

## Deployment

### Locally

`TBD`

### Github Action

`TBD`

## Provisioning

> Note: Only available if you have cloned the repository.

If you want to provision the box at startup

```sh
vagrant up midgar[-cts7|-cts|-deb|-ubt|-mnt] --provision
```

If you want to provision the box after startup

```sh
vagrant provision midgar[-cts7|-cts|-deb|-ubt|-mnt]
```

## Built With

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html) - Provisioning
- [Vagrant](https://www.vagrantup.com/downloads.html) - To build and manage the box.
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - The only provider available.

## Contributing

Please read [CONTRIBUTING.md](https://github.com/Pandemonium1986/.github/blob/main/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

##### Pre Committing

This repository use [pre-commit](https://pre-commit.com) to manage commit-msg, pre-commit and pre-push hooks (if necessary).
Be sure to install them before any push.

```sh
cd MY_REPO && \
pre-commit install --hook-type commit-msg && \
pre-commit install --hook-type pre-push && \
pre-commit install
```

For more info see this [cheatsheet](https://github.com/Pandemonium1986/cheatsheet/blob/main/Commit.md)

Also every commit MUST follow the [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/).

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/Pandemonium1986/vagrant-midgar/tags).

## Authors

- **Michael Maffait** - _Initial work_ - [Pandemonium1986](https://github.com/Pandemonium1986)

See also the list of [contributors](https://github.com/Pandemonium1986/vagrant-midgar/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details

## Note

#### Intentional non-compliance

In the provisioner folder. The `shell` provisioner names these directories according to the OS name, whereas the `ansible` provisioner names these directories according to the boxes delivered. This is voluntary, the shell provisioner takes care of configuring a dedicated OS while the ansible provisioner configures a box. The OS version can change.

```sh
# Dotfiles installation
cd ~/git/Pandemonium1986/vagrant-dotfiles
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
# sudo minikube config set driver none
# CHANGE_MINIKUBE_NONE_USER=true sudo -E minikube start --driver=none

# cts7 fix
sudo yum install libselinux-python3

# Dotfiles install cts7 & cts8
~/.local/bin/ansible-galaxy collection install ansible.posix
~/.local/bin/ansible-playbook install.yml -c local -i "127.0.0.1," -K

```

If you want to trigger the playbook mint locally

```sh
ansible-playbook mint.yml -i "localhost," -c local -K
```
