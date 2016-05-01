unless Vagrant.has_plugin?('vagrant-hostmanager')
    system("vagrant plugin install #{'vagrant-hostmanager'}")
    system("echo 'New plugins installed. Restarting Vagrant setup.'")
    exec "vagrant #{ARGV.join ' '}"
end

require 'vagrant-hostmanager'
Vagrant.configure(2) do |config|

  # Set base box and provisioning
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, path: "bootstrap.sh"
 
  # Provider resources
  config.vm.provider "virtualbox" do |v|
    v.name = "devbox.crizza.dev"
    v.memory = 512
    v.cpus = 4
  end
 
  # Networking
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.vm.hostname = 'devbox.crizza.dev'
  config.vm.network :private_network, ip: '192.168.99.12'

  # Shared folder
  config.vm.synced_folder '.', '/vagrant'
 
end
