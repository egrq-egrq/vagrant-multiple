# -*- mode: ruby -*-
# vi: set ft=ruby :

BASE_BOX_IMAGE    = "bento/centos-stream-10"
BASE_BOX_VERSION  = "202510.26.0"
BASE_IP           = "192.168.56."
NODE_COUNT        = 1
NODE_MEMORY       = 4096
NODE_CPUS         = 2

Vagrant.configure("2") do |config|
  config.vm.box              = BASE_BOX_IMAGE
  config.vm.box_version      = BASE_BOX_VERSION
  config.vm.box_check_update = false

  (1..NODE_COUNT).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.hostname = "node-#{i}"

      node.vm.network :private_network, ip: "#{BASE_IP}#{100 + i}"

      node.vm.provision "shell", inline: <<-SHELL
        echo "=================================================="
        echo "  VAGRANT NODE IS UP AND CONFIGURED"
        echo "--------------------------------------------------"
        echo "  Hostname : node-#{i}"
        echo "  IP       : #{BASE_IP}#{100 + i}"
        echo "  Time     : $(TZ='Europe/Moscow' date)""
        echo "=================================================="
      SHELL

      node.vm.provider "virtualbox" do |vb|
        vb.gui    = false
        vb.memory = NODE_MEMORY
        vb.cpus   = NODE_CPUS
      end
    end
  end
end
