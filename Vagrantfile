# -*- mode: ruby -*-
# vi: set ft=ruby :

$shellscript = <<-SHELLSCRIPT
sudo -s
apt-get update -y
apt-get install git gcc make pkgconf autoconf automake bison flex m4 linux-headers-$(uname -r) libc6-dev -y 
apt-get update -y
cd /linux-kernel-testing-ltp-vagrant/ltp-test-runner
make
git clone https://github.com/linux-test-project/ltp.git
cd ./ltp
make autotools
./configure
make all
make install
SHELLSCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "ltp-vagrant"
    vb.memory = "4096"
    vb.cpus = 4
  end
  
  config.vm.synced_folder ".", "/linux-kernel-testing-ltp-vagrant"

  config.vm.provision "shell", inline: $shellscript
end
