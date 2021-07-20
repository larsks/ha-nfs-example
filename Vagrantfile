# vim: set ft=ruby:

Vagrant.configure("2") do |config|
  num_ceph=3
  num_nfs=2
  num_clients=2

  config.vm.provider :libvirt do |libvirt|
    libvirt.uri = "qemu:///system"
    libvirt.memory = 4096
  end

  config.vm.box = "fedora/34-cloud-base"
  config.vm.box_version = "34.20210423.0"

  (1..num_ceph).each do |machine_id|
    config.vm.define "ceph#{machine_id}" do |ceph|
      ceph.vm.provider :libvirt do |libvirt|
        libvirt.storage :file,
          :size => "10G",
          :type => "qcow2"
      end
    end
  end

  (1..num_nfs).each do |machine_id|
    config.vm.define "nfs#{machine_id}" do |nfs|
    end
  end

  (1..num_clients).each do |machine_id|
    config.vm.define "client#{machine_id}" do |client|
      client.vm.provider :libvirt do |libvirt|
        libvirt.memory = 2048
      end
    end
  end

  config.vm.provision :ansible do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "common.yml"
    ansible.groups = {
      "ceph_servers" => Array.new(num_ceph) { |machine_id| "ceph#{machine_id+1}" },
      "nfs_servers" => Array.new(num_nfs) { |machine_id| "nfs#{machine_id+1}" },
      "clients" => Array.new(num_clients) { |machine_id| "client#{machine_id+1}" },
    }
  end
end
