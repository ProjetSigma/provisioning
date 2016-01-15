# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/vivid64"

  # Configure virtual machine specs. Keep it simple, single user.
  config.vm.provider :virtualbox do |p|
    p.customize ["modifyvm", :id, "--memory", 1024]
    p.customize ["modifyvm", :id, "--cpus", 1]
    # p.customize ["modifyvm", :id, "--cpuexecutioncap", 50]
    p.name = "ProjetSigma"
  end

  # Configure a synced folder between HOST and GUEST
  config.vm.synced_folder "..", "/vagrant", id: "vagrant-root", :mount_options => ["dmode=777","fmode=666"]

  # Config hostname and IP address so entry can be added to HOSTS file
  config.vm.hostname = "vagrant"
  config.vm.network :private_network, ip: '192.168.87.7'

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 5555, host: 5555

  # kickoff a shell script to install Python essentials
  config.vm.provision :shell, path: "vagrant_bootstrap.sh"
end
