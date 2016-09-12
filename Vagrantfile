Vagrant.configure(2) do |config|
  config.vm.define "postgresqlOnCentos7" do |postgresqlserver1|
    postgresqlserver1.vm.box = "custom_packer_built"
    postgresqlserver1.ssh.insert_key = false
    postgresqlserver1.vm.network :forwarded_port, host: 27018, guest: 22
    postgresqlserver1.vm.network "private_network", ip: "192.168.56.10", :netmask => "255.255.0.0"
    postgresqlserver1.vm.hostname = "postgresqlOnCentos7"
    postgresqlserver1.vm.provision :shell, inline: "systemctl enable firewalld"
    postgresqlserver1.vm.provision :shell, inline: "systemctl start firewalld"
    postgresqlserver1.vm.provider "virtualbox" do |v|
      v.gui = false
      memory = "1024"
      v.name = "postgresqlOnCentos7"
    end
  end

  config.vm.define "mysqlOnCentos7" do |mysqlserver1|
    mysqlserver1.vm.box = "custom_packer_built"
    mysqlserver1.ssh.insert_key = false
    mysqlserver1.vm.network :forwarded_port, host: 27019, guest: 22
    mysqlserver1.vm.network "private_network", ip: "192.168.56.11", :netmask => "255.255.0.0"
    mysqlserver1.vm.hostname = "mysqlOnCentos7"
    mysqlserver1.vm.provision :shell, inline: "systemctl enable firewalld"
    mysqlserver1.vm.provision :shell, inline: "systemctl start firewalld"
    mysqlserver1.vm.provider "virtualbox" do |v|
      v.gui = false
      memory = "1024"
      v.name = "mysqlOnCentos7"
    end
  end

end
