# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.ssh.insert_key = false

  config.vm.define "postgresqlOnCentos7" do |server|
    server.vm.network :forwarded_port, host: 27018, guest: 22
    server.vm.network "private_network", ip: "192.168.56.10", :netmask => "255.255.0.0"
    server.vm.hostname = "postgresqlOnCentos7"
  end

  config.vm.provision :shell, inline: "systemctl enable firewalld"
  config.vm.provision :shell, inline: "systemctl start firewalld"

  config.vm.provider "virtualbox" do |v|
    v.gui = false
    memory = "1024"
    v.name = "postgresqlOnCentos7"
  end
end

