# frozen_string_literal: true

Vagrant.require_version '>= 2.2.18'

Vagrant.configure('2') do |config|
  #########
  # Boxes #
  #########---------------------------------------------------------------------
  boxes = Hash[
    'centos7' => 'cts7',
    'centos8' => 'cts',
    'debian11' => 'deb',
    'ubuntu2004' => 'ubt',
    'mint1903' => 'mnt'
  ]

  ########################
  # Global configuration #
  ########################------------------------------------------------------
  config.vm.box_check_update = true
  config.vm.communicator = 'ssh'
  config.vm.graceful_halt_timeout = 60
  config.vm.synced_folder '.', '/vagrant', disabled: false

  config.vm.provider 'virtualbox' do |vb|
    vb.cpus = 2
    vb.customize ['modifyvm', :id, '--audio', 'none']
    vb.customize ['modifyvm', :id, '--boot1', 'dvd']
    vb.customize ['modifyvm', :id, '--boot2', 'disk']
    vb.customize ['modifyvm', :id, '--boot3', 'none']
    vb.customize ['modifyvm', :id, '--boot4', 'none']
    vb.customize ['modifyvm', :id, '--groups', '/Vagrant']
    vb.customize ['modifyvm', :id, '--vram', '64']
    vb.customize ['modifyvm', :id, '--vrde', 'off']
    vb.gui = false
    vb.linked_clone = false
    vb.memory = '4096'
  end
  #-----------------------------------------------------------------------------

  ##############################
  # Provisioning configuration #
  ##############################------------------------------------------------
  config.vm.provision 'ansible-midgar', type: 'ansible', run: 'once' do |ansible|
    ansible.compatibility_mode = '2.0'
    ansible.config_file = 'provisioner/ansible/ansible.cfg'
    ansible.galaxy_role_file = 'provisioner/ansible/requirements.yml'
    ansible.playbook = 'provisioner/ansible/midgar.yml'
  end
  #-----------------------------------------------------------------------------

  #######################
  # Boxes configuration #
  #######################-------------------------------------------------------
  boxes.each do |box, boxname|
    config.vm.define "midgar-#{boxname}" do |mybox|
      if "#{box}" == "mint1903" then
        mybox.vm.box = "pandemonium/#{box}"
        mybox.vm.box_version = '>= 1.0.0'
      else
        mybox.vm.box = "generic/#{box}"
        mybox.vm.box_version = '>= 3.5.2'
      end
      mybox.vm.hostname = "midgar-#{boxname}"
      # mybox.vm.network 'private_network', ip: '192.168.66.31'
      mybox.vm.post_up_message = "
        ################################
        ##  Starting midgar-#{boxname} done  ##
        ################################
      "
      mybox.vm.provision 'shell-config', type: 'shell', before: :all, run: 'once' do |shellconfig|
        shellconfig.path = "provisioner/shell/#{box}/config.sh"
        shellconfig.keep_color = 'true'
        shellconfig.name = 'shell-config'
      end
      mybox.vm.provision 'shell-vagrant', type: 'shell', run: 'never' do |shellvagrant|
        shellvagrant.path = "provisioner/shell/#{box}/vagrant.sh"
        shellvagrant.keep_color = 'true'
        shellvagrant.name = 'shell-vagrant'
      end
      mybox.vm.provision 'shell-cleanup', type: 'shell', after: :all, run: 'never' do |shellcleanup|
        shellcleanup.path = "provisioner/shell/#{box}/cleanup.sh"
        shellcleanup.keep_color = 'true'
        shellcleanup.name = 'shell-cleanup'
      end
      if "#{box}" == "mint1903" then
        mybox.vm.provision 'ansible-mint', type: 'ansible', run: 'once' do |ansiblemint|
          ansiblemint.compatibility_mode = '2.0'
          ansiblemint.config_file = 'provisioner/ansible/ansible.cfg'
          ansiblemint.playbook = 'provisioner/ansible/mint.yml'
        end
      end
      mybox.vm.provider :virtualbox do |vb|
        if "#{box}" == "mint1903" then
          vb.cpus = 2
          vb.memory = '8192'
        end
        vb.name = "midgar-#{boxname}"
        vb.customize ['modifyvm', :id, '--description', "
    ##############
    ### midgar-#{boxname} ###
    ##############
    #{box.capitalize} provisioned with :
    * Ansible collections: pandemonium k8s_toolbox
    * Ansible roles: pandemonium init, ohmyzsh, pip"
    ]
      end
    end
  end
end
