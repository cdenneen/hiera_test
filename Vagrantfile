# -*- mode: ruby -*-
# vi: set ft=ruby :
#
domain = "vm.local"

Vagrant.configure("2") do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  # (This should be the main box, though you can customize per box)
  config.vm.box = "centos-6.5-base"

  # Dan's original 1GB box is commented out
  # config.vm.box_url = "http://bit.ly/ap-ubuntu-lts"
  # Serdar's 512 MB remove
  #config.vm.box_url = "https://www.dropbox.com/s/ljxwxitt71vht46/ubuntu-12.04-server-amd64.box"
  # New VBox that is pre-provisioned with interact user
  #config.vm.box_url = "https://s3.amazonaws.com/associatedpress-data/vbox/ubuntu-12.04-server-amd64-2013-12-04.box"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box"
  #config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"

  # Change VM size if builds such as nginx fail due to gcc running out of RAM
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", 512]
    #vb.customize ["modifyvm", :id, "--memory", 1024]
  end

  # Toggle below value to turn management of host machine's /etc/hosts file
  config.hostmanager.manage_host = true

  #BINDFS PLUGIN SOLUTION
  # Only activate NFS lines below and run vagrant reload <server> AFTER 
  # you've done an initial vagrant up <server> (this is because the the interact
  # user does not exist during the first pass)
  config.vm.synced_folder "./files", "/etc/puppet/files"

  # Enable /etc/hosts update on vagrant up and reload
  config.hostmanager.enabled = true
  # Below causes all production boxes to be shadowed in all guest /etc/hosts,
  # even if guest machines are not active. This is intended to avoid
  # accidental requests to production machines. Use extreme caution
  # when testing guests against prod. In order to test integration with production,
  # you should temporarily modify /etc/hosts on a guest to pass through requests to
  # with production, and restore the file after testing is complete.
  config.hostmanager.include_offline = true

  config.vm.provision :shell, :path => "pre.sh"

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file  = "site.pp" #"nodes.pp"
     puppet.module_path    = "puppet/modules"
     puppet.hiera_config_path = "puppet/hiera.yaml"
     puppet.facter = { "vm_type" => "vagrant"}
     puppet.options = "--fileserverconfig=/vagrant/fileserver.conf"
     #puppet.options = "--verbose --debug --hiera_config /vagrant/puppet/hiera.yaml"
  end

  # Enable agent forwarding to support git deployment
  config.ssh.forward_agent = true

  config.vm.define :centos65 do |centos65|
    centos65.vm.hostname = "centos65" +  '.' + domain
    centos65.vm.network :private_network, ip: "192.168.10.20"
  end

end
