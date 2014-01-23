# -*- mode: ruby -*-
# vi: set ft=ruby :

# configuration
local_config = JSON.parse(File.read('config.json')) rescue {}
local_config['memory']  ||= [ ENV['DIAB_MEMORY'].to_i, 1536].max
local_config['cpus']    ||= [ ENV['DIAB_CPU'].to_i, 2].max
local_config['use_nfs'] ||= ENV['DIAB_NFS'] || false
local_config['ip']      ||= '10.1.0.10'
local_config['ports']   ||= {}

require './Vagrantfile.shared.rb'

Vagrant.configure('2') do |config|

  # http://vagrantup.com/v1/docs/config/ssh/forward_agent.html
  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", local_config['memory'], "--cpus", local_config['cpus']]
  end

  config.vm.box = 'diab'
  config.vm.box_url = 'https://oss-binaries.phusionpassenger.com/vagrant/boxes/ubuntu-12.04.3-amd64-vbox.box'
  config.vm.box_download_checksum = 'beea106fe041e0fa395efc0d7d11db34'
  config.vm.box_download_checksum_type = 'md5'

  config.vm.hostname = "%s.vagrant" % 'diab'

  if local_config['use_nfs']
    config.vm.synced_folder ".", "/vagrant", nfs: true
  end

  config.vm.network :private_network, ip: local_config['ip']

  local_config['ports'].each_pair do |service_name, port|
    puts " forwarding #{service_name} to #{port}"
    config.vm.network :forwarded_port, guest: port, host: port
  end

  config.berkshelf.enabled = true
  config.omnibus.chef_version = "11.8.0"
  
  config.vm.provision :chef_solo do |chef|
    add_recipes_to_chef(chef)
    chef.json = recipe_config
  end

end
