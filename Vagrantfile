# frozen_string_literal: true

Vagrant.require_version '>= 2.2.18'

Vagrant.configure('2') do |config|
  # Global configuration
  config.vm.box_check_update = true
  config.vm.communicator = 'ssh'
  config.vm.graceful_halt_timeout = 60
  config.vm.synced_folder ".", "/vagrant", disabled: false

  config.vm.provider 'virtualbox' do |vb|
    vb.cpus = 2
    vb.customize ['modifyvm', :id, '--audio', 'none']
    vb.customize ['modifyvm', :id, '--boot1', 'dvd']
    vb.customize ['modifyvm', :id, '--boot2', 'disk']
    vb.customize ['modifyvm', :id, '--boot3', 'none']
    vb.customize ['modifyvm', :id, '--boot4', 'none']
    vb.customize ['modifyvm', :id, '--groups', '/Vagrant']
    vb.customize ['modifyvm', :id, '--vram', '64']
    vb.gui = false
    vb.linked_clone = false
    vb.memory = '4096'
  end

  # Provisioning configuration
  config.vm.provision 'ansible-midgar', type: 'ansible', run: 'once' do |ansible|
    ansible.compatibility_mode = '2.0'
    ansible.config_file = 'ansible-provisioner/ansible.cfg'
    ansible.galaxy_role_file = 'ansible-provisioner/requirements.yml'
    ansible.playbook = 'ansible-provisioner/midgar.yml'
    ansible.host_vars = {
      'midgar-mnt' => {
        'ansible_python_interpreter' => '/usr/bin/python3',
        'ansible_distribution' => 'Ubuntu',
        'ansible_distribution_version' => 'Ubuntu.18'
      }
    }
  end

  # Centos box
  config.vm.define 'midgar-cts' do |cts|
    cts.vm.box = 'generic/centos8'
    cts.vm.box_version = '>= 3.4.2'
    cts.vm.hostname = 'midgar-cts'
    # cts.vm.network 'private_network', ip: '192.168.66.32'
    cts.vm.post_up_message = '
      ##################################
      ##   Starting midgar-cts done   ##
      ##################################
    '
    cts.vm.provision 'midgar-cts-shell-config', type: 'shell', run: 'once' do |shellconfig|
      shellconfig.path = 'provisioner/shell/centos8/config.sh'
      shellconfig.keep_color = 'true'
      shellconfig.name = 'midgar-cts-shell-config'
    end
    cts.vm.provision 'midgar-cts-shell-vagrant', type: 'shell', run: 'once' do |shellvagrant|
      shellvagrant.path = 'provisioner/shell/centos8/vagrant.sh'
      shellvagrant.keep_color = 'true'
      shellvagrant.name = 'midgar-cts-shell-vagrant'
    end
    cts.vm.provision 'midgar-cts-shell-cleanup', type: 'shell', run: 'once' do |shellcleanup|
      shellcleanup.path = 'provisioner/shell/centos8/cleanup.sh'
      shellcleanup.keep_color = 'true'
      shellcleanup.name = 'midgar-cts-shell-cleanup'
    end
    cts.vm.provider :virtualbox do |vb|
      vb.name = 'midgar-cts'
      vb.customize ['modifyvm', :id, '--description', "
##############
### midgar-cts ###
##############
Centos 8 provisioned with :
 * Pandemonium tools"]
    end
  end

  # Debian box
  config.vm.define 'midgar-deb' do |deb|
    deb.vm.box = 'pandemonium/debian10'
    deb.vm.box_version = '>= 1.0.0'
    deb.vm.hostname = 'midgar-deb'
    deb.vm.network 'private_network', ip: '192.168.66.30'
    deb.vm.post_up_message = 'Starting midgar-deb'
    deb.vm.provider :virtualbox do |vb|
      vb.name = 'midgar-deb'
      vb.customize ['modifyvm', :id, '--description', "
#################
### midgar-deb ###
#################
Pandemonium Vagrant Box
Debian 10.3.0 provisionnée avec le playbook midgar."]
    end
  end

  # Linux Mint box
  config.vm.define 'midgar-mnt' do |mnt|
    mnt.vm.box = 'pandemonium/mint1903'
    mnt.vm.box_version = '>= 1.0.0'
    mnt.vm.hostname = 'midgar-mnt'
    mnt.vm.network 'private_network', ip: '192.168.66.31'
    mnt.vm.post_up_message = 'Starting midgar-mnt'
    mnt.vm.provider :virtualbox do |vb|
      vb.cpus = 2
      vb.memory = '8192'
      vb.name = 'midgar-mnt'
      vb.customize ['modifyvm', :id, '--description', "
#################
### midgar-mnt ###
#################
Pandemonium Vagrant Box
Linux Mint 19.3 provisionnée avec le playbook midgar."]
    end
    mnt.vm.provision 'ansible-mint', type: 'ansible', run: 'once' do |ansible|
      ansible.compatibility_mode = '2.0'
      ansible.config_file = 'ansible-provisioner/ansible.cfg'
      ansible.playbook = 'ansible-provisioner/mint.yml'
    end
  end
end
