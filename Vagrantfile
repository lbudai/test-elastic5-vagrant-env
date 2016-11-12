Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.provision :shell, :inline => "ulimit -n 65536"
  config.vm.provision :shell, :path => File.expand_path("../bootstrap.sh", __FILE__)
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.provider :virtualbox do |vbox|
	  vbox.customize ['modifyvm', :id, '--memory', 4096]
  end
end
