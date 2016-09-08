Vagrant.configure(2) do |config|
  config.vm.define "postgresqlOnCentos7" do |server|
    server.vm.box = "custom_packer_built_sep2016_v1"
    server.ssh.insert_key = false
    server.vm.network :forwarded_port, host: 27018, guest: 22
    server.vm.network "private_network", ip: "192.168.56.10", :netmask => "255.255.0.0"
    server.vm.hostname = "postgresqlOnCentos7"
    server.vm.provision :shell, inline: "systemctl enable firewalld"
    server.vm.provision :shell, inline: "systemctl start firewalld"
      server.vm.provider "virtualbox" do |v|
        v.gui = false
        memory = "1024"
        v.name = "postgresqlOnCentos7"
      end
  end
end
