# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos7.1"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./lua", "/etc/nginx/lua/", type: "rsync"
  config.vm.synced_folder "./init.d", "/home/vagrant/init.d", type: "rsync"
  config.vm.synced_folder "./conf", "/home/vagrant/conf/", type: "rsync"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end
  config.vm.provider "virtualbox" do |vm|
    vm.customize ["modifyvm", :id, "--memory", "6144"]
  end
  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    mkdir log
    wget http://openresty.org/download/ngx_openresty-1.7.10.1.tar.gz
    tar xzvf ngx_openresty-1.7.10.1.tar.gz
    cd ngx_openresty-1.7.10.1
    sudo yum install -y pcre*
    sudo yum install -y openssl
    sudo yum install -y readline-devel pcre-devel openssl-devel
    sudo ./configure --with-luajit
    sudo gmake
    sudo gmake install
    cd ..
    sudo cp ./init.d/nginx /etc/init.d/nginx
    sudo chmod a+x /etc/init.d/nginx

    sudo cp ./conf/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
    sudo chmod a+x /usr/local/openresty/nginx/conf/nginx.conf
    sudo service nginx start

    # for fluentd
    wget https://curl.mirror.anstey.ca/curl-7.58.0.tar.bz2
    tar xf curl-7.58.0.tar.bz2
    cd curl-7.58.0
    ./configure --enable-libcurl-option
    make
    sudo make install
    curl --tlsv1.2 -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh

    # start
    # sudo /etc/init.d/td-agent start
  SHELL
end
