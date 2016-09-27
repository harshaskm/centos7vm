Vagrant.configure(2) do |config|
  config.vm.define "postgresqlOnCentos7" do |postgresqlserver1|
    postgresqlserver1.vm.box = "centos/7"
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
    mysqlserver1.vm.box = "centos/7"
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

  config.vm.define "citus1OnPgCentos7" do |citus1OnPgServer1|
    citus1OnPgServer1.vm.box = "centos/7"
    citus1OnPgServer1.ssh.insert_key = false
    citus1OnPgServer1.vm.network :forwarded_port, host: 27020, guest: 22
    citus1OnPgServer1.vm.network :forwarded_port, host: 9700, guest: 9700
    citus1OnPgServer1.vm.network :forwarded_port, host: 9701, guest: 9701
    citus1OnPgServer1.vm.network "private_network", ip: "192.168.56.12", :netmask => "255.255.0.0"
    citus1OnPgServer1.vm.hostname = "citus1OnPgCentos7"
    citus1OnPgServer1.vm.provision :shell, inline: "systemctl enable firewalld"
    citus1OnPgServer1.vm.provision :shell, inline: "systemctl start firewalld"
    citus1OnPgServer1.vm.provider "virtualbox" do |v|
      v.gui = false
      memory = "1024"
      v.name = "citus1OnPgCentos7"
    end
  end

end

