# -*- mode: ruby -*-
# vi: set ft=ruby :

$rbenv_script = <<SCRIPT
if [ ! -d ~/.rbenv ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
fi
if [ ! -d ~/.rbenv/plugins/ruby-build ]; then
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
fi
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
eval "$(rbenv init -)"
if [ ! -e .rbenv/versions/2.5.7 ]; then
  rbenv install 2.5.7
fi
cd /vagrant
if [ ! -e /home/vagrant/.rbenv/shims/bundle ]; then
  gem install bundler
  rbenv rehash
fi
bundle install
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "debian/buster64"
  config.vm.hostname = "help-37464"
  config.vm.define "help-37464"
  config.vagrant.plugins = ['vagrant-vbguest']

  config.vm.network "private_network", ip: "192.168.56.10"
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.synced_folder "./", "/home/vagrant/project"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 4
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get upgrade -y
    apt-get install -y wget gnupg git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev

    wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
    echo "deb http://repo.mongodb.com/apt/debian buster/mongodb-enterprise/4.2 main" >> /etc/apt/sources.list.d/mongodb-enterprise.list
    apt-get update
    apt-get install -y mongodb-enterprise=4.2.21

    systemctl start mongod
  SHELL

  config.vm.provision :shell, privileged: false, inline: $rbenv_script
end
