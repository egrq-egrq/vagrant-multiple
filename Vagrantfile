# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
cfg                       = YAML.load_file('config.yml')

instances                 = cfg["instances"] || {}
hardware                  = cfg["hardware"] || {}
vm_box_name_ubuntu        = (cfg["vm_box"] && cfg["vm_box"]["ubuntu"]) ? cfg["vm_box"]["ubuntu"]["name"] : ""
vm_box_version_ubuntu     = (cfg["vm_box"] && cfg["vm_box"]["ubuntu"]) ? cfg["vm_box"]["ubuntu"]["version"] : ""
vm_box_name_centos        = (cfg["vm_box"] && cfg["vm_box"]["centos"]) ? cfg["vm_box"]["centos"]["name"] : ""
vm_box_version_centos     = (cfg["vm_box"] && cfg["vm_box"]["centos"]) ? cfg["vm_box"]["centos"]["version"] : ""

ansible_playbook_path     = cfg["ansible_playbook_path"]
ansible_playbook_switch   = cfg["ansible_playbook_switch"]

master_synced_src         = cfg["master_synced_src"]
master_synced_dest        = cfg["master_synced_dest"]

Vagrant.configure("2") do |config|
  
  #########################################
  # Required parameters for Apple silicon #
  #    Successfully tested on apple m1    #
  ######################################### 

  # VMWare Desktop provider configuration
  config.vm.provider :vmware_desktop do |vmware|
    vmware.ssh_info_public = true
    vmware.gui             = true
    vmware.linked_clone    = false

    # Network device configurations
    (0..2).each do |i|
      vmware.vmx["ethernet#{i}.virtualdev"]    = "vmxnet3"
      vmware.vmx["ethernet#{i}.pcislotnumber"] = [160, 36, 20][i]
    end
  end

  # Master nodes configurations
  (1..instances["amount_master"]).each do |id_master|
    config.vm.define "master_#{id_master}" do |master|
      master.vm.hostname    = "Master-#{id_master}"
      master.vm.box         = vm_box_name_ubuntu
      master.vm.box_version = vm_box_version_ubuntu
      # master.vm.network "public_network", ip: "172.17.177.#{65+id_master}"
      master.vm.network "private_network", ip: "172.17.177.#{76+id_master}"

      # Set synced folders
      if ansible_playbook_switch["master"]["synced-folder"]
        master.vm.synced_folder "#{master_synced_src}", "#{master_synced_dest}"
      end      

      # Authorize by pubkey
      master.vm.provision "ansible", run: (ansible_playbook_switch["master"]["authorize-pubkey"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/authorize-pubkey/playbook.yml"
      end

      # Ansible install 
      master.vm.provision "ansible", run: (ansible_playbook_switch["master"]["install-ansible"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/install-ansible/playbook.yml"
      end

      # Copy ssh keys to server
      master.vm.provision "ansible", run: (ansible_playbook_switch["master"]["copy-sshkeys"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/copy-sshkeys/playbook.yml"
      end

      # Mitogen install
      master.vm.provision "ansible", run: (ansible_playbook_switch["master"]["install-mitogen"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/install-mitogen/playbook.yml"
      end

      # Docker install
      master.vm.provision "ansible", run: (ansible_playbook_switch["master"]["install-docker"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/install-docker/playbook.yml"
      end

      # MiniKube install
      master.vm.provision "ansible", run: (ansible_playbook_switch["master"]["install-minikube"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/install-minikube/playbook.yml"
      end

      # GitLab-server install and configure
      master.vm.provision "ansible", run: (ansible_playbook_switch["master"]["install-gitlab"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/install-gitlab/playbook.yml"
      end

      # Add groups to users
      master.vm.provision "ansible", run: (ansible_playbook_switch["master"]["usermod-groups"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/usermod-groups/playbook.yml"
      end

      # Assign Master specific hardware parameters
      master.vm.provider :vmware_desktop do |vmware|
        vmware.memory       = hardware["master"]["memory"]
        vmware.cpus         = hardware["master"]["cpu"]
      end
    end
  end

  # Ubuntu nodes configurations
  (1..instances["amount_ubuntu"]).each do |id_ubuntu_host|
    config.vm.define "ubuntu_#{id_ubuntu_host}" do |ubuntu|
      ubuntu.vm.hostname    = "Ubuntu-#{id_ubuntu_host}"
      ubuntu.vm.box         = vm_box_name_ubuntu
      ubuntu.vm.box_version = vm_box_version_ubuntu
      ubuntu.vm.network "private_network", ip: "172.17.177.#{100+id_ubuntu_host}"

      # Authorize by pubkey
      ubuntu.vm.provision "ansible", run: (ansible_playbook_switch["ubuntu"]["authorize-pubkey"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/authorize-pubkey/playbook.yml"
      end

      # Docker install
      ubuntu.vm.provision "ansible", run: (ansible_playbook_switch["ubuntu"]["install-docker"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/install-docker/playbook.yml"
      end
      
      # Add groups to users
      ubuntu.vm.provision "ansible", run: (ansible_playbook_switch["ubuntu"]["usermod-groups"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/usermod-groups/playbook.yml"
      end
      # Assign Ubuntu specific hardware parameters
      ubuntu.vm.provider :vmware_desktop do |vmware|
        vmware.memory       = hardware["ubuntu"]["memory"]
        vmware.cpus         = hardware["ubuntu"]["cpu"]
      end
    end
  end

  # CentOS nodes configurations
  (1..instances["amount_centos"]).each do |id_centos_host|
    config.vm.define "centos_#{id_centos_host}" do |centos|
      centos.vm.hostname    = "Centos-#{id_centos_host}"
      centos.vm.box         = vm_box_name_centos
      centos.vm.box_version = vm_box_version_centos
      centos.vm.network "private_network", ip: "172.17.177.#{200+id_centos_host}"

      # Authorize by pubkey
      centos.vm.provision "ansible", run: (ansible_playbook_switch["centos"]["authorize-pubkey"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/authorize-pubkey/playbook.yml"
      end

      # Docker install
      centos.vm.provision "ansible", run: (ansible_playbook_switch["centos"]["install-docker"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/install-docker/playbook.yml"
      end

      # Add groups to users
      centos.vm.provision "ansible", run: (ansible_playbook_switch["centos"]["usermod-groups"] ? "always" : "never") do |ansible|
        ansible.playbook    = "#{ansible_playbook_path}/usermod-groups/playbook.yml"
      end      

      # Assign CentOS specific hardware parameters
      centos.vm.provider :vmware_desktop do |vmware|
        vmware.memory       = hardware["centos"]["memory"]
        vmware.cpus         = hardware["centos"]["cpu"]
      end
    end
  end
end