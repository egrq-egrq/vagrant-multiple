NODES_COUNT       = 2

Vagrant.configure("2") do |config|
  config.vm.box   = "ppggff/centos-7-aarch64-2009-4K"

  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true

  (1..NODES_COUNT).each do |i|
    node_name     = "node-#{i}"

    config.vm.define node_name do |node|
      node.vm.hostname = node_name

      node.vm.provider "qemu" do |qe|
        qe.memory = "4G"
        qe.smp    = "2"
        qe.ssh_auto_correct = true
      end

      node.vm.provision "shell", inline: <<-SHELL
        echo "========================================================"
        echo "  #{node_name} is UP and READY"
        echo "  SSH user : vagrant"
        echo "========================================================"
      SHELL
    end
  end
end
